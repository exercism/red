Red/System [
	Title:   "Red memory allocator"
	Author:  "Nenad Rakocevic"
	File: 	 %allocator.reds
	Tabs:	 4
	Rights:  "Copyright (C) 2011-2018 Red Foundation. All rights reserved."
	License: {
		Distributed under the Boost Software License, Version 1.0.
		See https://github.com/red/red/blob/master/BSL-License.txt
	}
]

#enum collector-type! [
	COLLECTOR_DEFAULT
	COLLECTOR_RELEASE						;-- will release empty frames to OS
]

#define SERIES_BUFFER_PADDING	4

int-array!: alias struct! [ptr [int-ptr!]]

;-- cell header bits layout --
;	31:		lock							;-- lock series for active thread access only
;	30:		new-line						;-- new-line (LF) marker (before the slot)
;	29-25:	arity							;-- arity for routine! functions.
;	24:		self?							;-- self-aware context flag
;	23:		node-body						;-- op! body points to a block node (instead of native code)
;	22-19:	tuple-size						;-- size of tuple
;	18:		series-owned					;-- mark a series owned by an object
;	17:		owner							;-- indicate that an object is an owner
;	16:		native! op						;-- operator is made from a native! function
;	15:		extern flag						;-- routine code is external to Red (from FFI)
;	14:		sign bit						;-- sign of money
;	13:		dirty?							;-- word flag indicating if value has been modified
;	12-11:	context type					;-- context-type! value (context! cells only)
;	10:		trace							;-- force tracing mode attribut flag (function! cells only)
;	9:		no-trace						;-- disable tracing mode attribut flag (function! cells only)
;	8:		<reserved>
;	7-0:	datatype ID						;-- datatype number

cell!: alias struct! [
	header	[integer!]						;-- cell's header flags
	data1	[integer!]						;-- placeholders to make a 128-bit cell
	data2	[integer!]
	data3	[integer!]
]

;-- series flags --
;	31: 	used 							;-- 1 = used, 0 = free
;	30: 	type 							;-- always 0 for series-buffer!
;	29-28: 	insert-opt						;-- optimized insertions: 2 = head, 1 = tail, 0 = both
;   27:		mark							;-- mark as referenced for the GC (mark phase)
;   26:		lock							;-- lock series for active thread access only
;   25:		immutable						;-- mark as read-only
;   24:		big								;-- indicates a big series (big-frame!)
;	23:		small							;-- reserved
;	22:		stack							;-- series buffer is allocated on stack
;   21:		permanent						;-- protected from GC (system-critical series)
;   20:     fixed							;-- series cannot be relocated (system-critical series)
;	19:		complement						;-- complement flag for bitsets
;	18:		UTF-16 cache					;-- signifies that the string cache is UTF-16 encoded (UTF-8 by default)
;	17:		owned							;-- series is owned by an object
;	16-5: 	<reserved>
;	4-0:	unit							;-- size in bytes of atomic element stored in buffer
											;-- 0: UTF-8, 1: Latin1/binary, 2: UCS-2, 4: UCS-4, 16: block! cell
series-buffer!: alias struct! [
	flags	[integer!]						;-- series flags
	node	[int-ptr!]						;-- point back to referring node
	size	[integer!]						;-- usable buffer size (series-buffer! struct excluded)
	offset	[cell!]							;-- series buffer offset pointer (insert at head optimization)
	tail	[cell!]							;-- series buffer tail pointer 
]

series-frame!: alias struct! [				;-- series frame header
	next	[series-frame!]					;-- next frame or null
	prev	[series-frame!]					;-- previous frame or null
	heap	[series-buffer!]				;-- point to allocatable region
	tail	[byte-ptr!]						;-- point to last byte in allocatable region
]

node-frame!: alias struct! [				;-- node frame header
	next	[node-frame!]					;-- next frame or null
	prev	[node-frame!]					;-- previous frame or null
	nodes	[integer!]						;-- number of nodes
	bottom	[int-ptr!]						;-- bottom of stack (last entry, fixed)
	top		[int-ptr!]						;-- top of stack (first entry, moving)
]

big-frame!: alias struct! [					;-- big frame header (for >= 2MB series)
	flags	[integer!]						;-- bit 30: 1 (type = big)
	next	[big-frame!]					;-- next frame or null
	size	[integer!]						;-- size (up to 4GB - size? header)
	padding [integer!]						;-- make this header same size as series-buffer! header
]

memory: declare struct! [					; TBD: instanciate this structure per OS thread
	total	 [integer!]						;-- total memory size allocated (in bytes)
	n-head	 [node-frame!]					;-- head of node frames list
	n-active [node-frame!]					;-- actively used node frame
	n-tail	 [node-frame!]					;-- tail of node frames list
	s-head	 [series-frame!]				;-- head of series frames list
	s-active [series-frame!]				;-- actively used series frame
	s-tail	 [series-frame!]				;-- tail of series frames list
	s-start	 [integer!]						;-- start size for new series frame		(1)
	s-size	 [integer!]						;-- current size for new series frame	(1)
	s-max	 [integer!]						;-- max size for new series frames		(1)
	b-head	 [big-frame!]					;-- head of big frames list
	stk-refs [int-ptr!]						;-- buffer to stack references to update during GC
	stk-tail [int-ptr!]						;-- tail pointer on stack references buffer
	stk-sz	 [integer!]						;-- size of stack references buffer in 64-bits slots
]


init-mem: does [
	memory/total:		0
	memory/s-start:		_1MB
	memory/s-max:		_2MB
	memory/s-size:		memory/s-start
	memory/stk-sz:		1000
	memory/b-head:		null
	memory/stk-refs:	as int-ptr! allocate memory/stk-sz * 2 * size? int-ptr!
]

;; (1) Series frames size will grow from 1MB up to 2MB (arbitrary selected). This
;; range will need fine-tuning with real Red apps. This growing size, with low starting value
;; will allow small apps to not consume much memory while avoiding to penalize big apps.


;-------------------------------------------
;-- Fill a memory region with a given byte
;-------------------------------------------
fill: func [
	p	  [byte-ptr!]
	end   [byte-ptr!]
	byte  [byte!]
][
	set-memory p byte as-integer end - p
]

;-------------------------------------------
;-- Clear a memory region which size is a multiple of cell size
;-------------------------------------------
zerofill: func [
	p		[int-ptr!]
	end		[int-ptr!]
][
	assert p < end
	until [
		p/value: 0
		p: p + 1
		p = end
	]
]

;-------------------------------------------
;-- Allocate paged virtual memory region
;-------------------------------------------
allocate-virtual: func [
	size 	[integer!]						;-- allocated size in bytes (page size multiple)
	exec? 	[logic!]						;-- TRUE => executable region
	return: [int-ptr!]						;-- allocated memory region pointer
	/local ptr
][
	size: round-to size + 4	platform/page-size	;-- account for header (one word)
	memory/total: memory/total + size
	catch OS_ERROR_VMEM_ALL [
		ptr: platform/allocate-virtual size exec?
	]
	if system/thrown > OS_ERROR_VMEM [
		system/thrown: 0
		fire [TO_ERROR(internal no-memory)]
	]
	ptr/value: size							;-- store size in header
	ptr + 1									;-- return pointer after header
]

;-------------------------------------------
;-- Free paged virtual memory region from OS
;-------------------------------------------
free-virtual: func [
	ptr [int-ptr!]							;-- address of memory region to release
][
	ptr: ptr - 1							;-- return back to header
	memory/total: memory/total - ptr/value
	catch OS_ERROR_VMEM_ALL [
		platform/free-virtual ptr
	]
	if system/thrown > OS_ERROR_VMEM [
		system/thrown: 0
		fire [TO_ERROR(internal wrong-mem)]
	]
]

;-------------------------------------------
;-- Free all frames (part of Red's global exit handler)
;-------------------------------------------
free-all: func [
	/local n-frame s-frame b-frame n-next s-next b-next
][
	n-frame: memory/n-head
	while [n-frame <> null][
		n-next: n-frame/next
		free-virtual as int-ptr! n-frame
		n-frame: n-next
	]
	
	s-frame: memory/s-head
	while [s-frame <> null][
		s-next: s-frame/next
		free-virtual as int-ptr! s-frame
		s-frame: s-next
	]

	b-frame: memory/b-head
	while [b-frame <> null][
		b-next: b-frame/next
		free-virtual as int-ptr! b-frame
		b-frame: b-next
	]
]

;-------------------------------------------
;-- Format the node frame stack by filling it with pointers to all nodes
;-------------------------------------------
format-node-stack: func [
	frame [node-frame!]						;-- node frame to format
	/local node ptr
][
	ptr: frame/bottom						;-- point to bottom of stack
	node: ptr + frame/nodes					;-- first free node address
	until [
		ptr/value: as-integer node			;-- store free node address on stack
		node: node + 1
		ptr: ptr + 1
		ptr > frame/top						;-- until the stack is filled up
	]
]

;-------------------------------------------
;-- Allocate a node frame buffer and initialize it
;-------------------------------------------
alloc-node-frame: func [
	size 	[integer!]						;-- nb of nodes
	return:	[node-frame!]					;-- newly initialized frame
	/local sz frame
][
	assert positive? size
	sz: size * 2 * (size? pointer!) + (size? node-frame!) ;-- total required size for a node frame
	frame: as node-frame! allocate-virtual sz no ;-- R/W only

	frame/prev:  null
	frame/next:  null
	frame/nodes: size

	frame/bottom: as int-ptr! (as byte-ptr! frame) + size? node-frame!
	frame/top: frame/bottom + size - 1		;-- point to the top element
	
	either null? memory/n-head [
		memory/n-head: frame				;-- first item in the list
		memory/n-tail: frame
		memory/n-active: frame
	][
		memory/n-tail/next: frame			;-- append new item at tail of the list
		frame/prev: memory/n-tail			;-- link back to previous tail
		memory/n-tail: frame				;-- now tail is the new item
	]
	
	format-node-stack frame					;-- prepare the node frame for use
	frame
]

;-------------------------------------------
;-- Release a node frame buffer
;-------------------------------------------
free-node-frame: func [
	frame [node-frame!]						;-- frame to release
][
	either null? frame/prev [				;-- if frame = head
		memory/n-head: frame/next			;-- head now points to next one
	][
		either null? frame/next [			;-- if frame = tail
			memory/n-tail: frame/prev		;-- tail is now at one position back
		][
			frame/prev/next: frame/next		;-- link preceding frame to next frame
			frame/next/prev: frame/prev		;-- link back next frame to preceding frame
		]
	]
	if memory/n-active = frame [
		memory/n-active: memory/n-tail		;-- reset active frame to last one @@
	]

	assert not all [						;-- ensure that list is not empty
		null? memory/n-head
		null? memory/n-tail
	]
	
	free-virtual as int-ptr! frame			;-- release the memory to the OS
]

;-------------------------------------------
;-- Obtain a free node from a node frame
;-------------------------------------------
alloc-node: func [
	return: [int-ptr!]						;-- return a free node pointer
	/local frame node
][
	frame: memory/n-active					;-- take node from active node frame
	
	if frame/top < frame/bottom [
		frame: memory/n-head
		while [all [frame <> null frame/top < frame/bottom]][frame: frame/next]
		; TBD: trigger a "light" GC pass from here
		if null? frame [frame: alloc-node-frame nodes-per-frame] ;-- allocate a new frame
		memory/n-active: frame
	]
	node: as int-ptr! frame/top/value		;-- pop free node address from stack
	frame/top: frame/top - 1
	node
]

;-------------------------------------------
;-- Release a used node
;-------------------------------------------
free-node: func [
	node [int-ptr!]							;-- node to release
	/local frame offset
][
	if null? node [exit]					;-- node has been reused by a new expanded series buffer
	
	frame: memory/n-head					;-- search for right frame from head of the list
	while [									; @@ could be optimized by searching backward/forward from active frame
		offset: as-integer node - frame
		not all [							;-- test if node address is part of that frame
			positive? offset
			offset < node-frame-size		; @@ check upper bound case
		]
	][
		frame: frame/next
		assert frame <> null				;-- should found the right one before the list end
	]
	node/value: 0
	frame/top: frame/top + 1				;-- free node by pushing its address on stack
	frame/top/value: as-integer node
	assert frame/top < (frame/bottom + frame/nodes)	;-- top should not overflow
]

;-------------------------------------------
;-- Allocate a series frame buffer
;-------------------------------------------
alloc-series-frame: func [
	return:	[series-frame!]					;-- newly initialized frame
	/local size frame frm
][
	size: memory/s-size
	if size < memory/s-max [memory/s-size: size * 2]
	
	size: size + size? series-frame! 		;-- total required size for a series frame
	frame: as series-frame! allocate-virtual size no ;-- RW only
	frame/heap: as series-buffer! (as byte-ptr! frame) + size? series-frame!
	frame/tail: (as byte-ptr! frame) + size	;-- point to last byte in frame
	frame/next: null
	frame/prev: null
	
	frm: memory/s-head
	case [
		null? memory/s-head [
			memory/s-head: frame			;-- first item in the list
			memory/s-tail: frame
			memory/s-active: frame
			frame/prev:  null
		]
		frame < frm [
			frame/next: frm
			frm/prev: frame
			memory/s-head: frame
		]
		true [
			while [all [frm/next <> null frm < frame]][frm: frm/next]
			either all [frm/next = null frm < frame][
				frm/next: frame				;-- append new item at tail of the list
				frame/prev: frm				;-- link back to previous tail
				memory/s-tail: frame		;-- now tail is the new item
			][
				frame/prev: frm/prev		;-- insert frame in the linked list
				frame/next: frm
				frm/prev/next: frame
				frm/prev: frame
			]
		]
	]
	frame
]

;-------------------------------------------
;-- Release a series frame buffer
;-------------------------------------------
free-series-frame: func [
	frame [series-frame!]					;-- frame to release
][
	either null? frame/prev [				;-- if frame = head
		memory/s-head: frame/next			;-- head now points to next one
	][
		either null? frame/next [			;-- if frame = tail
			memory/s-tail: frame/prev		;-- tail is now at one position back
			frame/prev/next: null
		][
			frame/prev/next: frame/next		;-- link preceding frame to next frame
			frame/next/prev: frame/prev		;-- link back next frame to preceding frame
		]
	]
	if memory/s-active = frame [
		memory/s-active: memory/s-tail		;-- reset active frame to last one @@
	]

	assert not all [						;-- ensure that list is not empty
		null? memory/s-head
		null? memory/s-tail
	]
	
	free-virtual as int-ptr! frame			;-- release the memory to the OS
]

;-------------------------------------------
;-- Update moved series internal pointers
;-------------------------------------------
update-series: func [
	s		[series!]						;-- start of series region with nodes to re-sync
	offset	[integer!]
	size	[integer!]
	/local
		tail [byte-ptr!]
][
	tail: (as byte-ptr! s) + size
	until [
		s/node/value: as-integer s			;-- update the node pointer to the new series address
		s/offset: as cell! (as byte-ptr! s/offset) - offset	;-- update offset and tail pointers
		s/tail:   as cell! (as byte-ptr! s/tail) - offset
		s: as series! (as byte-ptr! s + 1) + s/size + SERIES_BUFFER_PADDING
		tail <= as byte-ptr! s
	]
]

;-------------------------------------------
;-- Compact a series frame by moving down in-use series buffer regions
;-------------------------------------------
compact-series-frame: func [
	frame	[series-frame!]					;-- series frame to compact
	refs	[int-ptr!]
	return: [int-ptr!]						;-- returns the next stack pointer to process
	/local
		tail  [int-ptr!]
		ptr	  [int-ptr!]
		s	  [series!]
		heap  [series!]
		src	  [byte-ptr!]
		dst	  [byte-ptr!]
		delta [integer!]
		size  [integer!]
		tail? [logic!]
][
	tail: memory/stk-tail
	s: as series! frame + 1					;-- point to first series buffer
	heap: frame/heap
	src: null								;-- src will point to start of buffer region to move down
	dst: null								;-- dst will point to start of free region

	;assert heap > s
	if heap = s [return refs]

	until [
		tail?: no
		if s/flags and flag-gc-mark = 0 [	;-- check if it starts with a gap
			if dst = null [dst: as byte-ptr! s]
			;probe ["search live from: " s]
			free-node s/node
			while [							;-- search for a live series
				s: as series! (as byte-ptr! s + 1) + s/size + SERIES_BUFFER_PADDING
				tail?: s >= heap
				not tail?
			][
				either s/flags and flag-gc-mark <> 0 [break][free-node s/node]
			]
			;probe ["live found at: " s]
		]
		unless tail? [
			src: as byte-ptr! s
			;probe ["search gap from: " s]
			until [							;-- search for a gap
				s/flags: s/flags and not flag-gc-mark	;-- clear mark flag
				s: as series! (as byte-ptr! s + 1) + s/size + SERIES_BUFFER_PADDING
				tail?: s >= heap
				;@@ test tail? first, otherwise s/flags may crash if s = heap
				any [tail? s/flags and flag-gc-mark = 0]
			]
			;probe ["gap found at: " s]
			if dst <> null [
				assert dst < src			;-- regions are moved down in memory
				assert src < as byte-ptr! s ;-- src should point at least at series - series/size
				
				size: as-integer (as byte-ptr! s) - src
				delta: as-integer src - dst
				;probe ["move src=" src ", dst=" dst ", size=" size]
				move-memory dst	src size
				update-series as series! dst delta size
				
				if refs < tail [			;-- update pointers on native stack
					while [all [refs < tail (as byte-ptr! refs/1) < src]][refs: refs + 2]
					while [all [refs < tail (as byte-ptr! refs/1) < (src + size)]][
						ptr: as int-ptr! refs/2
						ptr/value: ptr/value - delta
						refs: refs + 2
					]
				]
				dst: dst + size
			]
		]
		tail?
	]
	if dst <> null [						;-- no compaction occurred, all series were in use
		frame/heap: as series! dst			;-- set new heap after last moved region
		#if debug? = yes [markfill as int-ptr! frame/heap as int-ptr! frame/tail]
	]
	refs
]

cross-compact-frame: func [
	frame	[series-frame!]
	refs	[int-ptr!]
	return: [int-ptr!]
	/local
		prev	[series-frame!]
		free-sz [integer!]
		tail	[int-ptr!]
		ptr		[int-ptr!]
		s		[series!]
		ss		[series!]
		heap	[series!]
		src		[byte-ptr!]
		dst		[byte-ptr!]
		prev-dst [byte-ptr!]
		dst2	[byte-ptr!]
		delta	[integer!]
		size	[integer!]
		size2	[integer!]
		tail?	[logic!]
		cross?	[logic!]
		update? [logic!]
][
	prev: frame/prev
	if null? prev [							;-- first frame
		return compact-series-frame frame refs
	]

	prev-dst: as byte-ptr! prev/heap
	free-sz: as-integer prev/tail - prev/heap
	either free-sz > 52428 [cross?: yes][	;- 1MB * 5%
		free-sz: 0
		cross?: no
	]

	tail: memory/stk-tail
	s: as series! frame + 1					;-- point to first series buffer
	heap: frame/heap
	if heap = s [return refs]

	src: null								;-- src will point to start of buffer region to move down
	dst: null								;-- dst will point to start of free region
	tail?: no

	until [
		if s/flags and flag-gc-mark = 0 [	;-- check if it starts with a gap
			if dst = null [dst: as byte-ptr! s]
			free-node s/node
			while [							;-- search for a live series
				s: as series! (as byte-ptr! s + 1) + s/size + SERIES_BUFFER_PADDING
				tail?: s >= heap
				not tail?
			][
				either s/flags and flag-gc-mark <> 0 [break][free-node s/node]
			]
		]
		unless tail? [
			size: 0
			src: as byte-ptr! s
			until [							;-- search for a gap
				s/flags: s/flags and not flag-gc-mark	;-- clear mark flag
				size2: size
				size: SERIES_BUFFER_PADDING + size + s/size + size? series-buffer!
				ss: s						;-- save previous series pointer
				s: as series! (as byte-ptr! s + 1) + s/size + SERIES_BUFFER_PADDING
				tail?: s >= heap
				any [	;@@ test tail? first, otherwise s/flags may crash if s = heap
					tail?	
					all [cross? size >= free-sz]
					s/flags and flag-gc-mark = 0
				]
			]

			update?: yes
			case [
				any [
					size <= free-sz
					all [size2 > 0 size2 <= free-sz]
				][
					if dst = null [dst: src]
					if size > free-sz [
						size: size2
						s: ss
						s/flags: s/flags or flag-gc-mark
						tail?: no
					]
					free-sz: free-sz - size
					delta: as-integer src - prev-dst
					dst2: prev-dst
					prev-dst: prev-dst + size
				]
				dst <> null [
					assert dst < src			;-- regions are moved down in memory
					assert src < as byte-ptr! s ;-- src should point at least at series - series/size

					size: as-integer (as byte-ptr! s) - src
					delta: as-integer src - dst
					dst2: dst
					dst: dst + size
				]
				true [
					update?: no
					cross?: no
				]
			]

			if update? [
				move-memory dst2 src size
				update-series as series! dst2 delta size
				if refs < tail [			;-- update pointers on native stack
					while [all [refs < tail (as byte-ptr! refs/1) < src]][refs: refs + 2]
					while [all [refs < tail (as byte-ptr! refs/1) < (src + size)]][
						ptr: as int-ptr! refs/2
						ptr/value: ptr/value - delta
						refs: refs + 2
					]
				]
			]
		]
		tail?
	]

	prev/heap: as series! prev-dst
	if dst <> null [						;-- no compaction occurred, all series were in use
		frame/heap: as series! dst			;-- set new heap after last moved region
		#if debug? = yes [markfill as int-ptr! frame/heap as int-ptr! frame/tail]
	]
	if all [dst = as byte-ptr! (frame + 1) frame/next <> null][		;-- cache last one
		free-series-frame frame
	]
	refs
]

in-range?: func [
	p		[int-ptr!]
	return: [logic!]
	/local
		frm [series-frame!]
][
	frm: memory/s-head
	until [
		if all [(as int-ptr! frm + 1) <= p p < as int-ptr! frm/tail][return yes]
		frm: frm/next
		frm = null
	]
	no
]

compare-refs: func [[cdecl] a [int-ptr!] b [int-ptr!] return: [integer!]][
	as-integer (as int-ptr! a/value) - (as int-ptr! b/value)
]

extract-stack-refs: func [
	store? [logic!]
	/local
		top	  [int-ptr!]
		stk	  [int-ptr!]
		p	  [int-ptr!]
		refs  [int-ptr!]
		tail  [int-ptr!]
][
	top:  system/stack/top
	stk:  stk-bottom
	refs: memory/stk-refs
	tail: refs + (memory/stk-sz * 2)
	
	;probe ["native stack slots: " (as-integer stk - top) >> 2]
	until [
		stk: stk - 1
		p: as int-ptr! stk/value  
		if all [
			p > as int-ptr! FFFFh			;-- filter out too low values
			p < as int-ptr! FFFFF000h		;-- filter out too high values
			not all [(as byte-ptr! stack/bottom) <= p p <= (as byte-ptr! stack/top)] ;-- stack region is fixed
			in-range? p
		][	
			;probe ["stack pointer: " p " : " as byte-ptr! p/value]
			if store? [
				if refs = tail [
					;@@ for cases like issue #3628, should find a better way to handle it
					refs: memory/stk-refs
					memory/stk-sz: memory/stk-sz + 1000
					refs: as int-ptr! realloc as byte-ptr! refs memory/stk-sz * 2 * size? int-ptr!
					memory/stk-refs: refs
					tail: refs + (memory/stk-sz * 2)
					refs: tail - 2000
				]
				refs/1: as-integer p	;-- pointer inside a frame				
				refs/2: as-integer stk	;-- pointer address on stack
				refs: refs + 2
			]
		]
		stk = top
	]
	memory/stk-tail: refs
	
	if store? [
		qsort
			as byte-ptr! memory/stk-refs
			(as-integer refs - memory/stk-refs) >> 2 / 2
			8
			:compare-refs

		;tail: refs
		;refs: memory/stk-refs
		;until [
		;	probe [#"[" as int-ptr! refs/1 #":" as int-ptr! refs/2 #"]"]
		;	refs: refs + 2
		;	refs = tail
		;]
	]
]

collect-frames: func [
	type	  [integer!]
	/local
		frame [series-frame!]
		refs  [int-ptr!]
		next  [series-frame!]
][
	next: null
	refs: null
	frame: memory/s-head

	extract-stack-refs yes
	refs: memory/stk-refs

	until [
		;#if debug? = yes [check-series frame]

		;@@ current frame may be released
		;@@ rare case: the starting address of next frame may be identical to 
		;@@ the tail of the last frame, add 1 to avoid moving
		next: frame/next + 1

		either type = COLLECTOR_RELEASE [
			refs: cross-compact-frame frame refs
		][
			refs: compact-series-frame frame refs
		]

		frame: next - 1
		frame = null

		;#if debug? = yes [check-series frame]
	]
	collect-bigs
	;extract-stack-refs no
]



#if debug? = yes [

	markfill: func [
		p		[int-ptr!]
		end		[int-ptr!]
	][
		assert p < end
		until [
			p/value: BADCAFE0h
			p: p + 1
			p = end
		]
	]

	dump-frame: func [
		frame [series-frame!]				;-- series frame to compact
		/local
			s	  [series!]
			heap  [series!]
	][
		s: as series! frame + 1				;-- point to first series buffer
		heap: frame/heap

		until [
			either s/flags and flag-gc-mark = 0 [prin "x "][prin "o "]
			probe [s ": unit=" GET_UNIT(s) " size=" s/size]
			s: as series! (as byte-ptr! s + 1) + s/size + SERIES_BUFFER_PADDING
			s >= heap
		]

	]
	
	check-frames: func [
		/local
			frame [series-frame!]
	][
		frame: memory/s-head
		until [
			check-series frame
			frame: frame/next
			frame = null
		]
	]

	check-series: func [
		frame [series-frame!]				;-- series frame to compact
		/local
			s	  [series!]
			heap  [series!]
	][
		s: as series! frame + 1				;-- point to first series buffer
		heap: frame/heap

		while [heap > s][
			if any [
				(as byte-ptr! s/offset) <> as byte-ptr! s + 1
				(as byte-ptr! s/tail) < as byte-ptr! s
				(as byte-ptr! s/tail) > ((as byte-ptr! s/offset) + s/size)
			][
				probe "Corrupted series detected:"
				dump4 s
				halt
			]
			s: as series! (as byte-ptr! s + 1) + s/size + SERIES_BUFFER_PADDING
		]

	]
]

find-space: func [
	size	[integer!]
	return: [series-frame!]
	/local
		frame [series-frame!]
][
	frame: memory/s-head
	while [all [frame <> null ((as byte-ptr! frame/heap) + size) >= frame/tail]][
		frame: frame/next
	]
	frame
]

;-------------------------------------------
;-- Allocate a series from the active series frame, return the series
;-------------------------------------------
alloc-series-buffer: func [
	usize	[integer!]						;-- size in units
	unit	[integer!]						;-- size of atomic elements stored
	offset	[integer!]						;-- force a given offset for series buffer (in bytes)
	return: [series-buffer!]				;-- return the new series buffer
	/local 
		series	 [series-buffer!]
		frame	 [series-frame!]
		size	 [integer!]
		sz		 [integer!]
		flag-big [integer!]
][
	assert positive? usize
	size: round-to usize * unit size? cell!	;-- size aligned to cell! size

	frame: memory/s-active
	;-- add series header size + (extra padding 4 bytes)
	;-- extra space between two adjacent series-buffer!s (ensure s1/tail <> s2)
	sz: SERIES_BUFFER_PADDING + size + size? series-buffer!
	flag-big: 0
	series: null
	either (as byte-ptr! sz) >= (as byte-ptr! memory/s-max) [ ;-- alloc a big frame if too big for series frames
		collector/do-cycle					;-- launch a GC pass
		series: as series-buffer! alloc-big sz
		flag-big: flag-series-big
	][
		if ((as byte-ptr! frame/heap) + sz) >= frame/tail [ ;-- search for a suitable frame
			frame: find-space sz
			if null? frame [
				collector/do-cycle			;-- launch a GC pass
				frame: find-space sz
				if any [
					null? frame
					(as-integer frame/tail - frame/heap) < 52428	;- 1MB * 5%
				][
					if sz >= memory/s-size [ ;@@ temporary checks
						memory/s-size: memory/s-max
					]
					frame: alloc-series-frame
				]
			]
			memory/s-active: frame
		]
		assert sz < memory/s-max			;-- max series size allowed in a series frame
		series: frame/heap
		frame/heap: as series-buffer! (as byte-ptr! frame/heap) + sz
	]
		
	series/size: size
	series/flags: unit or series-in-use or flag-big

	either offset = default-offset [
		offset: size >> 1					;-- target middle of buffer
		series/flags: series/flags or flag-ins-both	;-- optimize for both head & tail insertions (default)
	][
		series/flags: series/flags or flag-ins-tail ;-- optimize for tail insertions only
	]
	
	series/offset: as cell! (as byte-ptr! series + 1) + offset
	series/tail: series/offset
	series
]

;-------------------------------------------
;-- Allocate a node and a series from the active series frame, return the node
;-------------------------------------------
alloc-series: func [
	size	[integer!]						;-- number of elements to store
	unit	[integer!]						;-- size of atomic elements stored
	offset	[integer!]						;-- force a given offset for series buffer
	return: [int-ptr!]						;-- return a new node pointer (pointing to the newly allocated series buffer)
	/local series [series!] node [int-ptr!]
][
;	#if debug? = yes [print-wide ["allocating series:" size unit offset lf]]
	series: null
	node: null
	series: alloc-series-buffer size unit offset
	node: alloc-node						;-- get a new node
	series/node: node						;-- link back series to node
	node/value: as-integer series ;(as byte-ptr! series) + size? series-buffer!
	node									;-- return the node pointer
]

;-------------------------------------------
;-- Allocate a series using malloc, return the node
;-------------------------------------------
alloc-fixed-series: func [
	usize	[integer!]						;-- number of elements to store
	unit	[integer!]						;-- size of atomic elements stored
	offset	[integer!]						;-- force a given offset for series buffer
	return: [int-ptr!]						;-- return a new node pointer (pointing to the newly allocated series buffer)
	/local
		series	 [series-buffer!]
		size	 [integer!]
		sz		 [integer!]
		node	 [int-ptr!]
][
;	#if debug? = yes [print-wide ["allocating series:" size unit offset lf]]
	assert positive? usize
	size: round-to usize * unit size? cell!	;-- size aligned to cell! size
	sz: size + size? series-buffer!			;-- add series header size

	series: as series-buffer! allocate sz
	series/size: size
	series/flags: unit or series-in-use or flag-series-fixed or flag-ins-tail
	series/offset: as cell! (as byte-ptr! series + 1) + offset
	series/tail: series/offset

	node: alloc-node						;-- get a new node
	series/node: node						;-- link back series to node
	node/value: as-integer series
	node									;-- return the node pointer
]

;-------------------------------------------
;-- Wrapper on alloc-series for easy cells allocation
;-------------------------------------------
alloc-cells: func [
	size	[integer!]						;-- number of 16 bytes cells to preallocate
	return: [int-ptr!]						;-- return a new node pointer (pointing to the newly allocated series buffer)	
][
	alloc-series size 16 0					;-- optimize by default for tail insertion
]

;-------------------------------------------
;-- Wrapper on alloc-cells for easy unset cells allocation
;-------------------------------------------
alloc-unset-cells: func [
	size	[integer!]						;-- number of 16 bytes cells to preallocate
	return: [int-ptr!]						;-- return a new node pointer (pointing to the newly allocated series buffer)
	/local
		node [node!]
		s	 [series!]
		p	 [int-ptr!]
		end	 [int-ptr!]
][
	node: alloc-series size 16 0
	s: as series! node/value
	p: as int-ptr! s/offset
	end: as int-ptr! ((as byte-ptr! s/offset) + s/size)
	
	assert p < end
	assert (as-integer end) and 3 = 0		;-- end should be a multiple of 4
	until [
		p/value: TYPE_UNSET
		p/2: 0
		p/3: 0
		p/4: 0
		p: p + 4
		p = end
	]
	node
]

;-------------------------------------------
;-- Wrapper on alloc-series for byte buffer allocation
;-------------------------------------------
alloc-bytes: func [
	size	[integer!]						;-- number of 16 bytes cells to preallocate
	return: [int-ptr!]						;-- return a new node pointer (pointing to the newly allocated series buffer)
][
	if zero? size [size: 16]
	alloc-series size 1 0					;-- optimize by default for tail insertion
]

;-------------------------------------------
;-- Wrapper on alloc-series for codepoints buffer allocation
;-------------------------------------------
alloc-codepoints: func [
	size	[integer!]						;-- number of codepoints slots to preallocate
	unit	[integer!]
	return: [int-ptr!]						;-- return a new node pointer (pointing to the newly allocated series buffer)
][
	assert unit <= 4
	if zero? size [size: 16 >> (unit >> 1)]
	alloc-series size unit 0				;-- optimize by default for tail insertion
]

;-------------------------------------------
;-- Wrapper on alloc-series for byte-filled buffer allocation
;-------------------------------------------
alloc-bytes-filled: func [
	size	[integer!]						;-- number of 16 bytes cells to preallocate
	byte	[byte!]
	return: [int-ptr!]						;-- return a new node pointer (pointing to the newly allocated series buffer)
	/local
		node [node!]
		s	 [series!]
][
	node: alloc-bytes size
	s: as series! node/value
	fill 
		as byte-ptr! s/offset
		(as byte-ptr! s/offset) + s/size
		byte
	node
]

;-------------------------------------------
;-- Set series header flags
;-------------------------------------------
set-flag: func [
	node	[node!]
	flags	[integer!]
	/local series
][
	series: as series-buffer! node/value
	series/flags: series/flags or flags	;-- apply flags
]

;-------------------------------------------
;-- Release a series
;-------------------------------------------
free-series: func [
	frame	[series-frame!]					;-- frame containing the series (should be provided by the GC)
	node	[int-ptr!]						;-- series' node pointer
	/local series
][
	assert not null? frame
	assert not null? node
	assert not null? (as byte-ptr! node/value)
	
	series: as series-buffer! node/value
	assert not zero? (series/flags and not series-in-use) ;-- ensure that 'used bit is set
	series/flags: series/flags and series-free-mask		  ;-- clear 'used bit (enough to free the series)
	
	if frame/heap = as series-buffer! (		;-- test if series is on top of heap
		(as byte-ptr! series) + SERIES_BUFFER_PADDING + series/size + size? series-buffer!
	) [
		frame/heap: series					;-- cheap collecting of last allocated series
	]
	free-node node
]

;-------------------------------------------
;-- Expand a series to a new size
;-------------------------------------------
expand-series: func [
	series  [series-buffer!]				;-- series to expand
	new-sz	[integer!]						;-- new size in bytes
	return: [series-buffer!]				;-- return new series with new size
	/local
		new	  [series-buffer!]
		node  [node!]
		units [integer!]
		delta [integer!]
		big?  [logic!]
][
	;#if debug? = yes [print-wide ["series expansion triggered for:" series new-sz lf]]
	
	assert not null? series
	assert any [
		zero? new-sz
		new-sz > series/size				;-- ensure requested size is bigger than current one
	]
	units: GET_UNIT(series)
	
	if zero? new-sz [new-sz: series/size * 2]	;-- by default, alloc twice the old size

	if new-sz <= 0 [fire [TO_ERROR(internal no-memory)]]

	node: series/node
	new: alloc-series-buffer new-sz / units units 0
	series: as series-buffer! node/value
	big?: new/flags and flag-series-big <> 0
	
	node/value: as-integer new		;-- link node to new series buffer
	delta: as-integer series/tail - series/offset
	
	new/flags:	series/flags
	new/node:	node
	new/tail:	as cell! (as byte-ptr! new/offset) + delta
	series/node: null
	
	if big? [new/flags: new/flags or flag-series-big]	;@@ to be improved
	
	;TBD: honor flag-ins-head and flag-ins-tail when copying!	
	copy-memory 							;-- copy old series in new buffer
		as byte-ptr! new/offset
		as byte-ptr! series/offset
		series/size
	
	assert not zero? (series/flags and not series-in-use) ;-- ensure that 'used bit is set
	series/flags: series/flags xor series-in-use		  ;-- clear 'used bit (enough to free the series)	
	new	
]

;-------------------------------------------
;-- Expand a series to a new size and zero-fill extra space
;-------------------------------------------
expand-series-filled: func [
	s		[series-buffer!]				;-- series to expand
	new-sz	[integer!]						;-- new size in bytes
	byte	[byte!]							;-- byte to fill the extended region with
	return: [series-buffer!]
	/local
		old [integer!]
][
	old: s/size
	s: expand-series s new-sz
	fill (as byte-ptr! s/offset) + old (as byte-ptr! s/offset) + s/size byte
	s
]
;-------------------------------------------
;-- Shrink a series to a smaller size (not needed for now)
;-------------------------------------------
;shrink-series: func [
;	series  [series-buffer!]
;	return: [series-buffer!]
;][
;
;]

;-------------------------------------------
;-- Copy a series buffer
;-------------------------------------------
copy-series: func [
	s 		[series!]
	return: [node!]
	/local
		node   [node!]
		new	   [series!]
][
	node: alloc-bytes s/size
	
	new: as series! node/value
	new/flags: s/flags
	new/tail: as cell! (as byte-ptr! new/offset) + (as-integer s/tail - s/offset)
	
	unless zero? s/size [
		copy-memory 
			as byte-ptr! new/offset
			as byte-ptr! s/offset
			s/size
	]
	node
]

collect-bigs: func [
	/local frame s
][
	frame: memory/b-head
	while [frame <> null][
		s: as series! (as byte-ptr! frame) + size? big-frame!
		frame: frame/next			;-- get next frame before free current frame
		either s/flags and flag-gc-mark = 0 [
			free-node s/node
			free-big as byte-ptr! s
		][
			s/flags: s/flags and not flag-gc-mark	;-- clear mark flag
		]
	]
]

;-------------------------------------------
;-- Allocate a big series
;-------------------------------------------
alloc-big: func [
	size	[integer!]						;-- buffer size to allocate (in bytes)
	return: [byte-ptr!]						;-- return allocated buffer pointer
	/local 
		sz	  [integer!]
		frame [big-frame!]
		frm	  [big-frame!]
][
	assert positive? size
	assert size >= _2MB						;-- should be bigger than a series frame
	
	sz: size + size? big-frame! 			;-- total required size for a big frame
	frame: as big-frame! allocate-virtual sz no ;-- R/W only

	frame/next: null
	frame/size: size
	
	either null? memory/b-head [
		memory/b-head: frame				;-- first item in the list
	][
		frm: memory/b-head					;-- search for tail of list (@@ might want to save it?)
		while [frm/next <> null][frm: frm/next]
		assert not null? frm		
		
		frm/next: frame						;-- append new item at tail of the list
	]
	
	(as byte-ptr! frame) + size? big-frame!	;-- return a pointer to the requested buffer
]

;-------------------------------------------
;-- Release a big series 
;-------------------------------------------
free-big: func [
	buffer	[byte-ptr!]						;-- big buffer to release
	/local frame frm
][
	assert not null? buffer
	
	frame: as big-frame! (buffer - size? big-frame!)  ;-- point to frame header
	
	either frame = memory/b-head [
		memory/b-head: frame/next
	][
		frm: memory/b-head					;-- search for frame position in list
		while [frm/next <> frame][			;-- frm should point to one item behind frame on exit
			frm: frm/next
			assert not null? frm			;-- ensure tail of list is not passed
		]
		frm/next: frame/next				;-- remove frame from list
	]
	
	free-virtual as int-ptr! frame			;-- release the memory to the OS
]

#if libRed? = yes [

	;-- Intermediary buffer used for holding Red values passed as arguments to an external
	;-- routine.
	
	ext-ring: context [
		head: as cell! 0
		tail: as cell! 0
		pos:  as cell! 0
		size: 50
		
		store: func [
			value	[cell!]
			return: [cell!]
		][
			copy-cell value alloc
		]
		
		alloc: func [return: [cell!]][
			pos: pos + 1
			if pos = tail [pos: head]
			pos
		]
		
		init: does [
			head: as cell! allocate size * size? cell!
			tail: head + size
			pos:  head
		]
		
		destroy: does [free as byte-ptr! head]
	]
	
]
