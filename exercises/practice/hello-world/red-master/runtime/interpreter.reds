Red/System [
	Title:   "Red interpreter"
	Author:  "Nenad Rakocevic"
	File: 	 %interpreter.reds
	Tabs:	 4
	Rights:  "Copyright (C) 2011-2018 Red Foundation. All rights reserved."
	License: {
		Distributed under the Boost Software License, Version 1.0.
		See https://github.com/red/red/blob/master/BSL-License.txt
	}
]

#define CHECK_INFIX [
	if all [
		next < end
		TYPE_OF(next) = TYPE_WORD
	][
		ctx: TO_CTX(next/ctx)
		if ctx/values <> null [
			value: _context/get next
			if TYPE_OF(value) = TYPE_OP [
				either next = as red-word! pc [
					#if debug? = yes [if verbose > 0 [log "infix detected!"]]
					infix?: yes
				][
					lit?: all [								;-- is a literal argument expected?
						any [TYPE_OF(pc) = TYPE_WORD TYPE_OF(pc) = TYPE_FUNCTION]
						literal-first-arg? as red-native! value ;-- left operand is a literal argument
						next + 1 < end						;-- disable infix detection if no right operand #3840
					]
					either lit? [
						#if debug? = yes [if verbose > 0 [log "infix detected!"]]
						infix?: yes
					][
						if TYPE_OF(pc) = TYPE_WORD [
							left: _context/get as red-word! pc
						]
						unless any [
							all [
								TYPE_OF(pc) = TYPE_FUNCTION
								literal-first-arg? as red-native! pc   ;-- a literal argument is expected
							]
							all [
								TYPE_OF(pc) = TYPE_WORD
								any [								   ;-- left operand is a function call
									TYPE_OF(left) = TYPE_ACTION
									TYPE_OF(left) = TYPE_NATIVE
									TYPE_OF(left) = TYPE_FUNCTION
								]
								literal-first-arg? as red-native! left ;-- a literal argument is expected
							]
						][
							#if debug? = yes [if verbose > 0 [log "infix detected!"]]
							infix?: yes
						]
					]
				]
				if infix? [
					if next + 1 = end [fire [TO_ERROR(script no-op-arg) next]]
				]
			]
		]
	]
]

#define FETCH_ARGUMENT [
	if pc >= end [fire [TO_ERROR(script no-arg) fname value]]
	
	switch TYPE_OF(value) [
		TYPE_WORD [
			#if debug? = yes [if verbose > 0 [log "evaluating argument"]]
			pc: eval-expression pc end code no yes no
		]
		TYPE_GET_WORD [
			#if debug? = yes [if verbose > 0 [log "fetching argument as-is"]]
			stack/push pc
			pc: pc + 1
		]
		default [
			#if debug? = yes [if verbose > 0 [log "fetching argument"]]
			switch TYPE_OF(pc) [
				TYPE_GET_WORD [
					copy-cell _context/get as red-word! pc stack/push*
				]
				TYPE_PAREN [
					either TYPE_OF(value) = TYPE_LIT_WORD [
						stack/mark-interp-native words/_anon
						eval as red-block! pc yes
						stack/unwind
					][
						stack/push pc
					]
				]
				TYPE_GET_PATH [
					eval-path pc pc + 1 end code no yes yes no
				]
				default [
					stack/push pc
				]
			]
			pc: pc + 1
			;if tracing? [fire-event EVT_PUSH code pc pc value yes]
		]
	]
]

interpreter: context [
	verbose: 0

	#enum events! [
		EVT_INIT:			00000001h
		EVT_END:			00000002h
		EVT_PROLOG:			00000004h
		EVT_EPILOG:			00000008h
		EVT_ENTER:			00000010h
		EVT_EXIT:			00000020h
		EVT_OPEN:			00000040h
		EVT_RETURN:			00000080h
		EVT_FETCH:			00000100h
		EVT_PUSH:			00000200h
		EVT_SET:			00000400h
		EVT_CALL:			00000800h
		EVT_ERROR:			00001000h
		EVT_THROW:			00002000h
		EVT_CATCH:			00004000h
		EVT_EXPR:			00008000h
		;EVT_EVAL_PATH:		00000000h					;-- reserved for future use
		;EVT_SET_PATH:		00000000h
	]
	
	trace?:		no										;-- yes: event mode active (only set by do/trace)
	tracing?:	no										;-- currently enabled/disabled event generation
	trace-fun:	as red-function! 0						;-- event handler reference (on stack)
	fun-locs:	0										;-- event handler locals count
	fun-evts:	0										;-- bitmask for encoding selected events
	all-events:	1FFFFh									;-- bit-mask of all events
	near:		declare red-block!						;-- Near: field in error! objects
	
	log: func [msg [c-string!]][
		print "eval: "
		print-line msg
	]
	
	decode-filter: func [fun [red-function!] return: [integer!]
		/local
			evts flag sym [integer!]
			value tail [red-word!]
			blk		   [red-block!]
			s		   [series!]
	][
		s: as series! fun/more/value
		blk: as red-block! s/offset
		if any [TYPE_OF(blk) <> TYPE_BLOCK block/rs-tail? blk][return all-events]
		blk: as red-block! block/rs-head blk
		if TYPE_OF(blk) <> TYPE_BLOCK [return all-events]

		s: GET_BUFFER(blk)
		value: as red-word! s/offset + blk/head
		tail:  as red-word! s/tail
		evts:  0
		while [value < tail][
			if TYPE_OF(value) = TYPE_WORD [
				sym: symbol/resolve value/symbol
				flag: case [
					sym = words/_prolog/symbol	[EVT_PROLOG]
					sym = words/_epilog/symbol	[EVT_EPILOG]
					sym = words/_enter/symbol	[EVT_ENTER]
					sym = words/_exit/symbol	[EVT_EXIT]
					sym = words/_fetch/symbol	[EVT_FETCH]
					sym = words/_push/symbol	[EVT_PUSH]
					sym = words/_open/symbol	[EVT_OPEN]
					sym = words/_return/symbol	[EVT_RETURN]
					sym = words/_set/symbol		[EVT_SET]
					sym = words/_call/symbol	[EVT_CALL]
					sym = words/_expr/symbol	[EVT_EXPR]
					sym = words/_error/symbol	[EVT_ERROR]
					sym = words/_init/symbol	[EVT_INIT]
					sym = words/_end/symbol		[EVT_END]
					sym = words/_throw/symbol	[EVT_THROW]
					sym = words/_catch/symbol	[EVT_CATCH]
					true						[0]				;-- ignore invalid names
				]
				evts: evts or flag
			]
			value: value + 1
		]
		evts
	]

	fire-event: func [
		event  	[events!]
		code	[red-block!]
		pc		[red-value!]
		ref		[red-value!]
		value   [red-value!]
		/local
			saved head tail [red-value!]
			evt   [red-word!]
			int	  [red-integer!]
			more  [series!]
			ctx	  [node!]
			len	base top i [integer!]
			csaved [int-ptr!]
	][
		assert all [trace-fun <> null TYPE_OF(trace-fun) = TYPE_FUNCTION]
		if fun-evts and event = 0 [exit]
		
		base: (as-integer stack/arguments - stack/bottom) >> 4
		top:  (as-integer stack/top - stack/bottom) >> 4
		saved: stack/top
		csaved: as int-ptr! stack/ctop
		stack/top: stack/top + 1						;-- keep last value
		more: as series! trace-fun/more/value
		int: as red-integer! more/offset + 4
		ctx: either TYPE_OF(int) = TYPE_INTEGER [as node! int/value][global-ctx]
		
		stack/mark-func words/_interp-cb trace-fun/ctx
		evt: switch event [
			EVT_PROLOG	[words/_prolog]
			EVT_EPILOG	[words/_epilog]
			EVT_ENTER	[words/_enter]
			EVT_EXIT	[words/_exit]
			EVT_FETCH	[words/_fetch]
			EVT_PUSH	[words/_push]
			EVT_OPEN	[words/_open]
			EVT_RETURN	[words/_return]
			EVT_SET		[words/_set]
			EVT_CALL	[words/_call]
			EVT_EXPR	[words/_expr]
			EVT_ERROR	[words/_error]
			EVT_INIT	[words/_init]
			EVT_END		[words/_end]
			EVT_THROW	[words/_throw]
			EVT_CATCH	[words/_catch]
			default		[assert false null]
		]
		stack/push as red-value! evt					;-- event name
		either null? code [
			stack/push none-value						;-- code
			integer/push -1								;-- offset
		][
			code: as red-block! stack/push as red-value! code
			i: either null? pc [-1][
				head: block/rs-head code
				tail: block/rs-tail code
				either all [head <= pc pc <= tail][(as-integer pc - head) >> 4][-1]
			]
			integer/push i
		]
		if any [value = null TYPE_OF(value) = 0][value: none-value]
		stack/push value								;-- value
		ref: switch event [
			EVT_CALL EVT_RETURN EVT_PROLOG EVT_EPILOG EVT_SET [ref]
			default [none-value]
		]
		stack/push ref									;-- reference (word, path,...)
		pair/push base top								;-- frame (pair!)
		if positive? fun-locs [_function/init-locals fun-locs]

		tracing?: no
		catch RED_THROWN_ERROR [_function/call trace-fun ctx as red-value! words/_interp-cb CB_INTERPRETER]
		if system/thrown <> 0 [re-throw]
		tracing?: yes
		
		stack/unwind
		stack/top: saved
		stack/set-ctop csaved
	]
	
	fire-init:	does [if tracing? [fire-event EVT_INIT null null null null]]
	fire-end:	does [if tracing? [fire-event EVT_END  null null null null]]
	fire-throw:	does [if tracing? [fire-event EVT_THROW null null null stack/arguments]]
	fire-catch:	does [if tracing? [fire-event EVT_CATCH null null null stack/arguments]]
	
	fire-call: func [ref [red-value!] fun [red-function!]][
		if tracing? [fire-event EVT_CALL null null ref as red-value! fun]
	]
	fire-return: func [ref [red-value!] fun [red-function!]][
		if tracing? [fire-event EVT_RETURN null null ref stack/arguments]
	]
	
	literal-first-arg?: func [
		native 	[red-native!]
		return: [logic!]
		/local
			fun	  [red-function!]
			value [red-value!]
			tail  [red-value!]
			s	  [series!]
	][
		s: as series! either TYPE_OF(native) = TYPE_FUNCTION [
			fun: as red-function! native
			fun/spec/value
		][
			native/spec/value
		]
		value: s/offset
		tail:  s/tail
		
		while [value < tail][
			switch TYPE_OF(value) [
				TYPE_WORD 		[return no]
				TYPE_LIT_WORD
				TYPE_GET_WORD	[return yes]
				default 		[0]
			]
			value: value + 1
		]
		no
	]
	
	set-locals: func [
		fun [red-function!]
		/local
			tail  [red-value!]
			value [red-value!]
			s	  [series!]
			set?  [logic!]
	][
		s: as series! fun/spec/value
		value: s/offset
		tail:  s/tail
		set?:  no
		
		while [value < tail][
			switch TYPE_OF(value) [
				TYPE_WORD
				TYPE_GET_WORD
				TYPE_LIT_WORD [
					if set? [none/push]
				]
				TYPE_REFINEMENT [
					unless set? [set?: yes]
					logic/push false
				]
				default [0]								;-- ignore other values
			]
			value: value + 1
		]
	]
	
	eval-function: func [
		fun  [red-function!]
		body [red-block!]
		ref  [red-value!]								;-- referent word! or path!
		/local
			ctx		 [red-context!]
			saved	 [node!]
			thrown	 [integer!]
			prev	 [logic!]
			force?	 [logic!]
			prevent? [logic!]
	][
		ctx: GET_CTX(fun)
		saved: ctx/values
		ctx/values: as node! stack/arguments
		stack/set-in-func-flag yes
		prev: tracing?
		force?:   fun/header and flag-force-trace <> 0
		prevent?: fun/header and flag-no-trace <> 0
		if force?   [tracing?: trace?]					;-- force tracing only if trace mode enabled
		if prevent? [tracing?: no]						;-- force tracing only if trace mode enabled
		
		if tracing? [
			catch RED_THROWN_ERROR [fire-event EVT_PROLOG body null ref as red-value! fun]
			if system/thrown >= RED_THROWN_THROW [
				stack/set-in-func-flag no
				ctx/values: saved
				re-throw
			]
			system/thrown: 0
		]
		assert system/thrown = 0
		
		catch RED_THROWN_ERROR [eval body yes]
		
		if tracing? [
			thrown: system/thrown
			system/thrown: 0
			fire-event EVT_EPILOG body null ref as red-value! fun
			system/thrown: thrown
		]
		if any [force? prevent?][tracing?: prev]
		stack/set-in-func-flag no
		ctx/values: saved
		switch system/thrown [
			RED_THROWN_ERROR
			RED_THROWN_BREAK
			RED_THROWN_CONTINUE
			RED_THROWN_THROW	[re-throw]				;-- let exception pass through
			default [0]									;-- else, do nothing
		]
		system/thrown: 0
	]
	
	exec-routine: func [
		rt [red-routine!]
		/local
			native	[red-native!]
			arg		[red-value!]
			base	[red-value!]
			bool	[red-logic!]
			int		[red-integer!]
			fl		[red-float!]
			value	[red-value!]
			tail	[red-value!]
			dt		[red-datatype!]
			w		[red-word!]
			s		[series!]
			ret		[integer!]
			retf	[float!]
			sym		[integer!]
			count	[integer!]
			cnt 	[integer!]
			args	[integer!]
			type	[integer!]
			saved	[int-ptr!]
			pos		[byte-ptr!]
			bits 	[byte-ptr!]
			set? 	[logic!]
			extern?	[logic!]
			call callf callex
	][
		extern?: rt/header and flag-extern-code <> 0
		s: as series! rt/more/value
		native: as red-native! s/offset + 2
		args: routine/get-arity rt
		count: args - 1				;-- zero-based stack access
		
		either extern? [
			base: stack/arguments
			;@@ cdecl is hardcoded in the caller, needs to be dynamic!
			callex: as function! [[cdecl custom] return: [integer!]] native/code
			stack/mark-native words/_body
			
			#if stack-align-16? = yes [
				saved: system/stack/align
				cnt: 4 - (count + 1 and 3)
				while [cnt > 0][push 0 cnt: cnt - 1]
			]
			#if target = 'ARM [
				saved: system/stack/align
			]
			while [count >= 0][
				arg: base + count
				#either libRed? = yes [
					push red/ext-ring/store arg			;-- copy the exported values to libRed's buffer
				][
					push arg
				]
				count: count - 1
			]
			arg: as red-value! callex args
			#either any [stack-align-16? = yes target = 'ARM][	;@@ 64-bit alignment required on ARM
				system/stack/top: saved
			][
				pop args
			]
			stack/unwind
			stack/set-last arg
		][
			call: as function! [return: [integer!]] native/code

			s: as series! rt/spec/value
			value: s/offset
			tail:  s/tail
			
			until [										;-- scan forward for end of arguments
				switch TYPE_OF(value) [
					TYPE_SET_WORD
					TYPE_REFINEMENT [break]
					default			[0]
				]
				value: value + 1
				value >= tail
			]

			while [count >= 0][							;-- push arguments in reverse order
				value: value - 1
				if TYPE_OF(value) =	TYPE_BLOCK [
					w: as red-word! block/rs-head as red-block! value
					if TYPE_OF(w) <> TYPE_WORD [fire [TO_ERROR(script invalid-type-spec) w]]
					sym: w/symbol
					arg: stack/arguments + count
					
					if sym <> words/any-type! [			;-- type-checking argument
						dt: as red-datatype! _context/get w
						case [
							TYPE_OF(dt)	= TYPE_TYPESET [
								bits: (as byte-ptr! dt) + 4
								type: TYPE_OF(arg)
								BS_TEST_BIT(bits type set?)
								unless set? [ERR_EXPECT_ARGUMENT(dt/value count)]
							]
							TYPE_OF(arg) = dt/value [0]	;-- all good, do nothing
							true [ERR_EXPECT_ARGUMENT(dt/value count)]
						]
					]
					case [
						sym = words/logic!	 [push logic/get arg]
						sym = words/integer! [push integer/get arg]
						sym = words/float!	 [push float/get arg]
						true		 		 [push arg]
					]
					count: count - 1
				]
			]
			either positive? rt/ret-type [
				switch rt/ret-type [
					TYPE_LOGIC	[
						ret: call
						bool: as red-logic! stack/arguments
						bool/header: TYPE_LOGIC
						bool/value: ret <> 0
					]
					TYPE_INTEGER [
						ret: call
						int: as red-integer! stack/arguments
						int/header: TYPE_INTEGER
						int/value: ret
					]
					TYPE_FLOAT [
						callf: as function! [return: [float!]] native/code
						retf: callf
						fl: as red-float! stack/arguments
						fl/header: TYPE_FLOAT
						fl/value: retf
					]
					default [assert false]				;-- should never happen
				]
			][call]
		]
	]
	
	eval-infix: func [
		value 	  [red-value!]
		pc		  [red-value!]
		end		  [red-value!]
		code	  [red-block!]
		sub?	  [logic!]
		return:   [red-value!]
		/local
			next	[red-word!]
			left	[red-value!]
			fun		[red-function!]
			ctx		[red-context!]
			blk		[red-block!]
			slot	[red-value!]
			arg		[red-value!]
			more	[red-value!]
			op-pos	[red-value!]
			infix?	[logic!]
			op		[red-op!]
			s		[series!]
			type	[integer!]
			pos		[byte-ptr!]
			bits	[byte-ptr!]
			native? [logic!]
			set?	[logic!]
			lit?	[logic!]							;-- required by CHECK_INFIX macro
			args	[node!]
			node	[node!]
			call-op
	][
		stack/keep
		op-pos: pc
		pc: pc + 1										;-- skip operator
		either all [									;-- is a literal argument is expected?
			TYPE_OF(pc) = TYPE_WORD
			literal-first-arg? as red-native! value
		][
			stack/push pc
			pc: pc + 1
		][
			pc: eval-expression pc end code yes yes no	;-- eval right operand
		]
		op: as red-op! value
		fun: null
		native?: op/header and flag-native-op <> 0

		unless native? [
			either op/header and body-flag <> 0 [
				node: as node! op/code
				s: as series! node/value
				more: s/offset
				fun: as red-function! more + 3

				s: as series! fun/more/value
				blk: as red-block! s/offset + 1
				args: either TYPE_OF(blk) = TYPE_BLOCK [blk/node][null]
			][
				args: op/args
			]

			if null? args [
				args: _function/preprocess-spec as red-native! op
				either fun <> null [
					blk/header: TYPE_BLOCK
					blk/head:	0
					blk/node:	args
				][
					op/args: args
				]
			]
			s: as series! args/value
			slot: s/offset + 1
			bits: (as byte-ptr! slot) + 4
			arg:  stack/arguments
			type: TYPE_OF(arg)
			BS_TEST_BIT(bits type set?)
			unless set? [ERR_EXPECT_ARGUMENT(type 0)]

			slot: slot + 2
			bits: (as byte-ptr! slot) + 4
			arg:  arg + 1
			type: TYPE_OF(arg)
			BS_TEST_BIT(bits type set?)
			unless set? [ERR_EXPECT_ARGUMENT(type 1)]
		]
		if tracing? [fire-event EVT_CALL code pc op-pos as red-value! op]
		
		either fun <> null [
			either TYPE_OF(fun) = TYPE_ROUTINE [
				exec-routine as red-routine! fun
			][
				set-locals fun
				eval-function fun as red-block! more op-pos
			]
		][
			if native? [push yes]						;-- type-checking for natives.
			call-op: as function! [] op/code
			call-op
			0											;-- @@ to make compiler happy!
		]
		if tracing? [fire-event EVT_RETURN code pc op-pos stack/arguments]
		
		#if debug? = yes [
			if verbose > 0 [
				value: stack/arguments
				print-line ["eval: op return type: " TYPE_OF(value)]
			]
		]
		infix?: no
		next: as red-word! pc
		CHECK_INFIX
		if infix? [
			stack/update-call pc						;-- keep same frame, just update the op reference
			if tracing? [
				fire-event EVT_FETCH code pc pc pc
				fire-event EVT_OPEN code pc pc pc
			]
			pc: eval-infix value pc end code sub?
		]
		pc
	]
	
	eval-arguments: func [
		native 	[red-native!]
		pc		[red-value!]
		end	  	[red-value!]
		code	[red-block!]
		path	[red-path!]
		ref-pos [red-value!]
		origin	[red-native!]
		return: [red-value!]
		/local
			fun	  	  [red-function!]
			function? [logic!]
			routine?  [logic!]
			value	  [red-value!]
			tail	  [red-value!]
			expected  [red-value!]
			path-end  [red-value!]
			fname	  [red-word!]
			blk		  [red-block!]
			vec		  [red-vector!]
			bool	  [red-logic!]
			arg		  [red-value!]
			ext-args  [red-value!]
			saved	  [red-value!]
			base	  [red-value!]
			s-value	  [red-value!]
			call-pos  [red-value!]
			s		  [series!]
			required? [logic!]
			args	  [node!]
			p		  [int-ptr!]
			ref-array [int-ptr!]
			extras	  [int-ptr!]
			offset	  [int-ptr!]
			v-tail	  [int-ptr!]
			index	  [integer!]
			size	  [integer!]
			type	  [integer!]
			ext-size  [integer!]
			pos		  [byte-ptr!]
			bits 	  [byte-ptr!]
			ordered?  [logic!]
			set? 	  [logic!]
			call
	][
		routine?:  TYPE_OF(native) = TYPE_ROUTINE
		function?: any [routine? TYPE_OF(native) = TYPE_FUNCTION]
		call-pos:  pc - 1
		fname:	   as red-word! call-pos
		args:	   null
		ref-array: null

		either function? [
			fun: as red-function! native
			s: as series! fun/more/value
			blk: as red-block! s/offset + 1
			if TYPE_OF(blk) = TYPE_BLOCK [args: blk/node]
		][
			args: native/args
		]
		if null? args [
			args: _function/preprocess-spec native
			
			either function? [
				blk/header: TYPE_BLOCK
				blk/head:	0
				blk/node:	args
				blk/extra:	0
			][
				native/args: args
				origin/args: args
			]
		]
		
		unless null? path [
			path-end: block/rs-tail as red-block! path
			fname: as red-word! ref-pos
			
			if ref-pos + 1 < path-end [					;-- test if refinements are following the function
				either null? path/args [
					args: _function/preprocess-options native path ref-pos args fname function?
					path/args: args
				][
					args: path/args
				]
			]
			fname: as red-word! path
		]
		
		s: as series! args/value
		value:	   s/offset
		tail:	   s/tail
		required?: yes
		index: 	   0
		extras:	   null
		ordered?:  yes
		
		while [value < tail][
			expected: value + 1
			
			switch TYPE_OF(value) [
				TYPE_ISSUE [
					vec: as red-vector! expected
					if TYPE_OF(vec) = TYPE_VECTOR [
						extras: as int-ptr! vector/rs-head vec
						v-tail: as int-ptr! vector/rs-tail vec
						ext-size: (as-integer v-tail - extras) >>> 2 - 1
						offset: extras
						ordered?: no
						
						saved: stack/top				;-- move stack/top beyond current frame for ooo args
						stack/top: stack/top + offset/value
						ext-args: stack/top
						offset: offset + 1
						base: s/offset + 2				;-- skip ooo entry
						s-value: value
						
						while [offset < v-tail][
							expected: base + (offset/value * 2 - 1)
							value: expected - 1
							assert TYPE_OF(expected) = TYPE_TYPESET
							bits: (as byte-ptr! expected) + 4
							BS_TEST_BIT(bits TYPE_UNSET set?)

							either all [
								set?					;-- if unset! is accepted
								pc >= end				;-- if no more values to fetch
								TYPE_OF(value) = TYPE_LIT_WORD ;-- and if spec argument is a lit-word!
							][
								unset/push				;-- then, supply an unset argument
							][
								FETCH_ARGUMENT
								arg:  stack/top - 1
								type: TYPE_OF(arg)
								BS_TEST_BIT(bits type set?)
								unless set? [
									index: offset/value - 1
									fire [
										TO_ERROR(script expect-arg)
										fname
										datatype/push type
										error/get-call-argument index
									]
								]
							]
							offset: offset + 1
						]
						value: s-value
						stack/top: saved
					]
				]
				TYPE_SET_WORD [0]
				default [
					switch TYPE_OF(expected) [
						TYPE_TYPESET [
							either all [required? ordered?][
								bits: (as byte-ptr! expected) + 4
								BS_TEST_BIT(bits TYPE_UNSET set?)

								either all [
									set?					;-- if unset! is accepted
									pc >= end				;-- if no more values to fetch
									TYPE_OF(value) = TYPE_LIT_WORD ;-- and if spec argument is a lit-word!
								][
									unset/push				;-- then, supply an unset argument
								][
									FETCH_ARGUMENT
									arg:  stack/top - 1
									type: TYPE_OF(arg)
									BS_TEST_BIT(bits type set?)
									unless set? [
										fire [
											TO_ERROR(script expect-arg)
											fname
											datatype/push type
											value
										]
									]
									index: index + 1
								]
							][
								none/push
							]
						]
						TYPE_LOGIC [
							stack/push expected
							bool: as red-logic! expected
							required?: bool/value
						]
						TYPE_VECTOR [
							vec: as red-vector! expected
							s: GET_BUFFER(vec)
							p: as int-ptr! s/offset
							size: (as-integer (as int-ptr! s/tail) - p) / 4
							ref-array: system/stack/top - size
							system/stack/top: ref-array		;-- reserve space on native stack for refs array
							copy-memory as byte-ptr! ref-array as byte-ptr! p size * 4
						]
						default [assert false]				;-- trap it, if stack corrupted 
					]
				]
			]
			value: value + 2
		]
		unless ordered? [
			offset: extras + 1
			loop ext-size [
				copy-cell ext-args stack/arguments + offset/value - 1
				offset: offset + 1
				ext-args: ext-args + 1
			]
		]
		if tracing? [fire-event EVT_CALL code pc call-pos as red-value! native]
		
		unless function? [
			unless null? ref-array [system/stack/top: ref-array] ;-- reset native stack to our custom arguments frame
			if TYPE_OF(native) = TYPE_NATIVE [push no]	;-- avoid 2nd type-checking for natives.
			call: as function! [] native/code			;-- direct call for actions/natives
			call
		]
		pc
	]
	
	eval-path: func [
		value   [red-value!]							;-- path to evaluate
		pc		[red-value!]
		end		[red-value!]
		code	[red-block!]
		set?	[logic!]
		get?	[logic!]
		sub?	[logic!]
		case?	[logic!]
		return: [red-value!]
		/local
			head tail item parent gparent saved prev arg p-item [red-value!]
			path  [red-path!]
			obj	  [red-object!]
			w	  [red-word!]
			ser	  [red-series!]
			type idx [integer!]
			tail? [logic!]
	][
		#if debug? = yes [if verbose > 0 [print-line "eval: path"]]
		
		path: as red-path! value
		head: block/rs-head as red-block! path
		tail: block/rs-tail as red-block! path
		if head = tail [fire [TO_ERROR(script empty-path)]]
		if tracing? [fire-event EVT_ENTER as red-block! path head null null]
		if tracing? [fire-event EVT_FETCH as red-block! path head head head]
		
		item:  head + 1
		saved: stack/top
		idx:   0
		
		if TYPE_OF(head) <> TYPE_WORD [fire [TO_ERROR(script word-first) path]]
		
		p-item: head
		w: as red-word! head
		parent: _context/get w
		gparent: null
		
		switch TYPE_OF(parent) [
			TYPE_ACTION									;@@ replace with TYPE_ANY_FUNCTION
			TYPE_NATIVE
			TYPE_ROUTINE
			TYPE_FUNCTION [
				if set? [fire [TO_ERROR(script invalid-path-set) path]]
				if get? [fire [TO_ERROR(script invalid-path-get) path]]
				pc: eval-code parent pc end code yes path item - 1 parent
				unless sub? [stack/set-last stack/top]
				if tracing? [fire-event EVT_EXIT as red-block! path tail null stack/arguments]
				return pc
			]
			TYPE_UNSET [fire [TO_ERROR(script unset-path) path head]]
			default	   [0]
		]
		if tracing? [fire-event EVT_PUSH as red-block! path head head parent]

		if w/ctx <> global-ctx [
			obj: as red-object! GET_CTX(w) + 1
			if TYPE_OF(obj) <> TYPE_OBJECT [gparent: as red-value! obj]
		]
		
		while [item < tail][
			#if debug? = yes [if verbose > 0 [print-line ["eval: path parent: " TYPE_OF(parent)]]]
			
			if tracing? [fire-event EVT_FETCH as red-block! path item item item]
			
			value: switch TYPE_OF(item) [ 
				TYPE_GET_WORD [_context/get as red-word! item]
				TYPE_PAREN 	  [
					eval as red-block! item no			;-- eval paren content
					stack/top - 1
				]
				default [item]
			]
			if tracing? [fire-event EVT_PUSH as red-block! path item item value]
			if TYPE_OF(value) = TYPE_UNSET [fire [TO_ERROR(script invalid-path) path item]]
			#if debug? = yes [if verbose > 0 [print-line ["eval: path item: " TYPE_OF(value)]]]
			
			;-- invoke eval-path action
			prev: parent
			type: TYPE_OF(parent)
			tail?: item + 1 = tail
			arg: either all [set? tail?][stack/arguments][null]
			parent: actions/eval-path parent value arg path gparent p-item idx case? get? tail?

			if all [not get? not set?][
				switch TYPE_OF(parent) [
					TYPE_ACTION							;@@ replace with TYPE_ANY_FUNCTION
					TYPE_NATIVE
					TYPE_ROUTINE
					TYPE_FUNCTION [
						pc: eval-code parent pc end code sub? path item prev
						parent: stack/get-top
						item: tail						;-- force loop exit
					]
					default [0]
				]
			]
			p-item: item
			gparent: prev								;-- save previous parent reference
			item: item + 1
			idx: idx + 1
		]
		if tracing? [fire-event EVT_EXIT as red-block! path tail null parent]

		stack/top: saved
		either sub? [stack/push parent][stack/set-last parent]
		pc
	]
	
	eval-code: func [
		value	[red-value!]
		pc		[red-value!]
		end		[red-value!]
		code	[red-block!]
		sub?	[logic!]
		path	[red-path!]
		slot 	[red-value!]
		parent	[red-value!]
		return: [red-value!]
		/local
			caller origin [red-native!]
			pos	  [red-value!]
			name  [red-word!]
			obj   [red-object!]
			fun	  [red-function!]
			int	  [red-integer!]
			s	  [series!]
			ctx	  [node!]
	][
		pos: pc - 1
		name: as red-word! either null? slot [pos][slot]
		if tracing? [fire-event EVT_OPEN code pc pos as red-value! name]

		if TYPE_OF(name) <> TYPE_WORD [name: words/_anon]
		caller: as red-native! stack/push value			;-- prevent word's value slot to be corrupted #2199
		origin: as red-native! value
		
		switch TYPE_OF(value) [
			TYPE_ACTION 
			TYPE_NATIVE [
				#if debug? = yes [if verbose > 0 [log "pushing action/native frame"]]
				stack/mark-interp-native name
				assert any [code = null TYPE_OF(code) = TYPE_BLOCK TYPE_OF(code) = TYPE_PAREN TYPE_OF(code) = TYPE_HASH]
				pc: eval-arguments caller pc end code path slot origin ;-- fetch args and exec
				either sub? [stack/unwind][stack/unwind-last]
				#if debug? = yes [
					if verbose > 0 [
						value: stack/arguments
						print-line ["eval: action/native return type: " TYPE_OF(value)]
					]
				]
			]
			TYPE_ROUTINE [
				#if debug? = yes [if verbose > 0 [log "pushing routine frame"]]
				stack/mark-interp-native name
				pc: eval-arguments caller pc end code path slot origin
				exec-routine as red-routine! caller
				either sub? [stack/unwind][stack/unwind-last]
				#if debug? = yes [
					if verbose > 0 [
						value: stack/arguments
						print-line ["eval: routine return type: " TYPE_OF(value)]
					]
				]
			]
			TYPE_FUNCTION [
				#if debug? = yes [if verbose > 0 [log "pushing function frame"]]
				obj: as red-object! parent
				ctx: either all [
					parent <> null
					TYPE_OF(parent) = TYPE_OBJECT
					obj/ctx <> global-ctx
				][
					obj/ctx
				][
					fun: as red-function! value
					s: as series! fun/more/value
					int: as red-integer! s/offset + 4
					either TYPE_OF(int) = TYPE_INTEGER [
						as node! int/value
					][
						name/ctx						;-- get a context from calling name
					]
				]
				stack/mark-interp-func name
				pc: eval-arguments origin pc end code path slot origin
				_function/call as red-function! caller ctx pos CB_INTERPRETER
				either sub? [stack/unwind][stack/unwind-last]
				#if debug? = yes [
					if verbose > 0 [
						value: stack/arguments
						print-line ["eval: function return type: " TYPE_OF(value)]
					]
				]
			]
		]
		if tracing? [fire-event EVT_RETURN code pc pos stack/get-top]
		
		stack/pop 1										;-- slide down the returned value
		copy-cell stack/top stack/top - 1				;-- replacing the saved value slot
		pc
	]
	
	eval-expression: func [
		pc		  [red-value!]
		end	  	  [red-value!]
		code	  [red-block!]
		prefix?	  [logic!]								;-- TRUE => don't check for infix
		sub?	  [logic!]
		passive?  [logic!]
		return:   [red-value!]
		/local
			saved  [red-value! value]
			next   [red-word!]
			ctx	   [red-context!]
			value  [red-value!]
			left   [red-value!]
			pos    [red-value!]
			start  [red-value!]
			w	   [red-word!]
			op	   [red-value!]
			sym	   [integer!]
			infix? [logic!]
			lit?   [logic!]
			top?   [logic!]
	][
		#if debug? = yes [if verbose > 0 [print-line ["eval: fetching value of type " TYPE_OF(pc)]]]
		
		lit?: no
		infix?: no
		start: pc
		top?: not sub?
		
		unless prefix? [
			next: as red-word! pc + 1
			CHECK_INFIX
			if infix? [
				if tracing? [
					fire-event EVT_FETCH code pc as red-value! next as red-value! next
					fire-event EVT_OPEN  code pc as red-value! next as red-value! next
				]
				stack/mark-interp-native next
				sub?: yes								;-- force sub? for infix expressions
				op: copy-cell value saved
			]
		]
		if tracing? [fire-event EVT_FETCH code pc pc pc]
		
		switch TYPE_OF(pc) [
			TYPE_PAREN [
				stack/mark-interp-native words/_body
				eval as red-block! pc yes
				either sub? [stack/unwind][stack/unwind-last]
				pc: pc + 1
				if tracing? [value: stack/arguments]
			]
			TYPE_SET_WORD [
				either infix? [
					value: either sub? [stack/push pc][stack/set-last pc]
					if tracing? [fire-event EVT_PUSH code pc pc value]
					pc: pc + 1
				][
					stack/mark-interp-native as red-word! pc ;@@ ~set
					word/push as red-word! pc
					if tracing? [fire-event EVT_PUSH code pc pc pc]
					pos: pc
					pc: pc + 1
					if pc >= end [fire [TO_ERROR(script need-value) pc - 1]]
					pc: eval-expression pc end code no yes no
					if tracing? [
						value: stack/get-top
						fire-event EVT_SET code pc pos value
					]
					word/set
					either sub? [stack/unwind][stack/unwind-last]
					#if debug? = yes [
						if verbose > 0 [
							value: stack/arguments
							print-line ["eval: set-word return type: " TYPE_OF(value)]
						]
					]
				]
			]
			TYPE_SET_PATH [
				value: pc
				if tracing? [fire-event EVT_PUSH code pc pc pc]
				pc: pc + 1
				if pc >= end [fire [TO_ERROR(script need-value) value]]
				stack/mark-interp-native words/_set-path
				pc: eval-expression pc end code no yes no	;-- yes: push value on top of stack
				if tracing? [fire-event EVT_SET code pc value stack/get-top]
				pc: eval-path value pc end code yes no sub? no
				either sub? [stack/unwind][stack/unwind-last]
				if tracing? [value: stack/arguments]
			]
			TYPE_GET_WORD [
				value: _context/get as red-word! pc
				value: either sub? [
					stack/push value					;-- nested expression: push value
				][
					stack/set-last value				;-- root expression: return value
				]
				if tracing? [fire-event EVT_PUSH code pc pc value]
				pc: pc + 1
			]
			TYPE_LIT_WORD [
				either sub? [
					w: word/push as red-word! pc			;-- nested expression: push value
				][
					w: as red-word! stack/set-last pc		;-- root expression: return value
				]
				w/header: TYPE_WORD						;-- coerce it to a word!
				if tracing? [
					value: as red-value! w
					fire-event EVT_PUSH code pc pc value
				]
				pc: pc + 1
			]
			TYPE_WORD [
				#if debug? = yes [
					if verbose > 0 [
						print "eval: '"
						print-symbol as red-word! pc
						print lf
					]
				]
				value: either lit? [pc][_context/get as red-word! pc]
				pc: pc + 1
				
				switch TYPE_OF(value) [
					TYPE_UNSET	  [fire [TO_ERROR(script no-value) pc - 1]]
					TYPE_LIT_WORD [
						if tracing? [fire-event EVT_PUSH code pc pc - 1 value]
						word/push as red-word! value	;-- push lit-word! on stack
					]
					TYPE_ACTION							;@@ replace with TYPE_ANY_FUNCTION
					TYPE_NATIVE
					TYPE_ROUTINE
					TYPE_FUNCTION [
						pc: eval-code value pc end code sub? null null value
						if tracing? [value: stack/arguments]
					]
					TYPE_OP [
						fire [TO_ERROR(script no-op-arg) pc - 1]
					]
					default [
						if tracing? [fire-event EVT_PUSH code pc - 1 pc - 1 value]
						#if debug? = yes [if verbose > 0 [log "getting word value"]]
						value: either sub? [
							stack/push value			;-- nested expression: push value
						][
							stack/set-last value		;-- root expression: return value
						]
						#if debug? = yes [
							if verbose > 0 [
								value: stack/arguments
								print-line ["eval: word return type: " TYPE_OF(value)]
							]
						]
					]
				]
			]
			TYPE_PATH [
				value: pc
				pc: pc + 1
				pc: eval-path value pc end code no no sub? no
				if tracing? [
					value: either sub? [stack/get-top][stack/arguments]
					fire-event EVT_PUSH code pc pc value
				]
			]
			TYPE_GET_PATH [
				value: pc
				pc: pc + 1
				pc: eval-path value pc end code no yes sub? no
				if tracing? [
					fire-event EVT_PUSH code value value stack/arguments
					value: stack/arguments
				]
			]
			TYPE_LIT_PATH [
				value: either sub? [stack/push pc][stack/set-last pc]
				value/header: TYPE_PATH
				value/data3: 0							;-- ensures args field is null
				if tracing? [fire-event EVT_PUSH code pc pc - 1 value]
				pc: pc + 1
			]
			TYPE_OP [
				--NOT_IMPLEMENTED--						;-- op used in prefix mode
			]
			TYPE_ACTION									;@@ replace with TYPE_ANY_FUNCTION
			TYPE_NATIVE
			TYPE_ROUTINE
			TYPE_FUNCTION [
				either passive? [
					value: either sub? [
						stack/push pc					;-- nested expression: push value
					][
						stack/set-last pc				;-- root expression: return value
					]
					if tracing? [fire-event EVT_PUSH code pc pc value]
					pc: pc + 1
				][
					value: pc + 1
					if value >= end [value: end]
					pc: eval-code pc value end code sub? null null null
					if tracing? [value: stack/arguments]
				]
			]
			TYPE_ISSUE [
				value: pc + 1
				if all [
					value < end
					TYPE_OF(value) = TYPE_BLOCK
				][
					w: as red-word! pc
					sym: symbol/resolve w/symbol
					
					if any [
						sym = words/system
						sym = words/system-global
					][
						fire [TO_ERROR(internal red-system)]
					]
				]
				value: either sub? [
					stack/push pc						;-- nested expression: push value
				][
					stack/set-last pc					;-- root expression: return value
				]
				if tracing? [fire-event EVT_PUSH code pc pc value]
				pc: pc + 1
			]
			default [
				value: either sub? [
					stack/push pc						;-- nested expression: push value
				][
					stack/set-last pc					;-- root expression: return value
				]
				if tracing? [fire-event EVT_PUSH code pc pc value]
				pc: pc + 1
			]
		]
		
		if infix? [
			if pc >= end [fire [TO_ERROR(script no-op-arg) next]]
			pc: eval-infix op pc end code sub?
			unless prefix? [either sub? [stack/unwind][stack/unwind-last]]
			if tracing? [value: either sub? [stack/get-top][stack/arguments]]
		]
		if all [tracing? top?][fire-event EVT_EXPR code pc start value]
		pc
	]
	
	eval-single: func [
		value	[red-value!]
		return: [integer!]								;-- return index of next expression
		/local
			blk	 [red-block!]
			s	 [series!]
			node [node!]
	][
		blk: as red-block! value
		s: GET_BUFFER(blk)
		if s/offset + blk/head = s/tail [
			unset/push-last
			return blk/head
		]
		node: blk/node									;-- save node pointer as slot will be overwritten
		value: eval-next blk s/offset + blk/head s/tail no
		
		s: as series! node/value						;-- refresh buffer pointer
		assert all [s/offset <= value value <= s/tail]
		(as-integer value - s/offset) >> 4
	]

	eval-next: func [
		code	[red-block!]
		value	[red-value!]
		tail	[red-value!]
		sub?	[logic!]
		return: [red-value!]							;-- return start of next expression
	][
		stack/mark-interp-native words/_body			;-- outer stack frame
		value: eval-expression value tail code no sub? no
		either sub? [stack/unwind][stack/unwind-last]
		value
	]
	
	eval: func [
		code   [red-block!]
		chain? [logic!]									;-- chain it with previous stack frame
		/local
			value head tail arg [red-value!]
			saved [red-block! value]
	][
		head: block/rs-head code
		tail: block/rs-tail code
		copy-cell as red-value! near as red-value! saved

		stack/mark-eval words/_body						;-- outer stack frame
		if tracing? [fire-event EVT_ENTER code head null null]
		either head = tail [
			arg: stack/arguments
			arg/header: TYPE_UNSET
		][
			copy-cell as red-value! code as red-value! near ;-- initialize near cell
			value: head
			
			while [value < tail][
				#if debug? = yes [if verbose > 0 [log "root loop..."]]
				near/head: (as-integer value - head) >> 4
				value: eval-expression value tail code no no no
				if value + 1 <= tail [stack/reset]
			]
		]
		if tracing? [fire-event EVT_EXIT code tail null stack/arguments]
		copy-cell as red-value! saved as red-value! near
		either chain? [stack/unwind-last][stack/unwind]
	]
	
	init: does [
		trace-fun: as red-function! ALLOC_TAIL(root)	;-- keep the tracing func reachable by the GC marker
		
		near/header: TYPE_UNSET
		near/extra:  0
	]
]
