Red/System [
	Title:   "Red/System pointer! datatype test script"
	Author:  "Nenad Rakocevic"
	File: 	 %pointer-test.reds
	Tabs:	 4
	Rights:  "Copyright (C) 2011-2018 Red Foundation. All rights reserved."
	License: "BSD-3 - https://github.com/red/red/blob/origin/BSD-3-License.txt"
]

#include %../../../../quick-test/quick-test.reds

~~~start-file~~~ "pointer!"

===start-group=== "Pointers simple read/write tests"

	--test-- "pointer-rw-1"
	p-struct: declare struct! [n [integer!] m [integer!]]
	pA: declare pointer! [integer!]
	pB: declare pointer! [integer!]

	p-struct/n: 123
	--assert p-struct/n = 123

	--test-- "pointer-rw-2"
	pA: as [pointer! [integer!]] p-struct
	pA/value: 987
	--assert p-struct/n = 987
	pA/1: 987
	--assert p-struct/n = 987

	--test-- "pointer-rw-3"
	p-struct/n: 12345
	--assert pA/value = 12345
	--assert pA/1 = 12345

	--test-- "pointer-rw-4"
	p-int: 456789
	pA/2: p-int
	--assert p-struct/m = p-int
	--assert p-struct/n = 12345			;-- look for memory corruption

	--test-- "pointer-rw-5"
	p-idx: 1
	pA/p-idx: 1234567890
	--assert p-struct/n = 1234567890

	--test-- "pointer-rw-6"
	p-idx: 2
	pA/p-idx: 963
	--assert p-struct/n = 1234567890
	--assert p-struct/m = 963

	--test-- "pointer-rw-7"
	p-struct/n: 12345
	p-int: 147258
	p-struct/m: p-int
	--assert pA/2 = p-int
	--assert p-struct/n = 12345			;-- look for memory corruption

	--test-- "pointer-rw-8"
	pB: pA
	--assert pB/value = 12345

	--test-- "pointer-rw-9"
	foo-pointer: func [
		a [pointer! [integer!]]
		return: [pointer! [integer!]]
	][
		a
	]

	pB: foo-pointer pA 
	--assert pB/value = 12345

	pointer-str: declare struct! [
		A [pointer! [integer!]]
		B [pointer! [integer!]]
		sub [
			struct! [
				C [pointer! [integer!]]
			]
		]
	]
	pointer-str/sub: declare struct! [C [pointer! [integer!]]]

	--test-- "pointer-rw-10"
	pointer-str/A: pA
	--assert pointer-str/A/value = 12345

	--test-- "pointer-rw-11"
	pointer-str/A/value: 258369147
	--assert p-struct/n = 258369147
	--assert p-struct/m = p-int				;-- look for memory corruption			

	--test-- "pointer-rw-12"
	pointer-str/sub/C: pA
	--assert pointer-str/sub/C/value = 258369147

	--test-- "pointer-rw-13"
	pointer-str/sub/C/2: 987654321
	--assert p-struct/m = 987654321
	
	--test-- "pointer-rw-14"
	b-pointer: declare pointer! [byte!]
	b-str: "hello"
	b-pointer: as [pointer! [byte!]] b-str
	--assert b-pointer/value = #"h"
	
	--test-- "pointer-rw-15"
	foo-b-pointer: func [
		a [pointer! [byte!]]
		return: [pointer! [byte!]]
	][
		a
	]
	b-pointer2: declare pointer! [byte!]

	b-pointer2: foo-b-pointer b-pointer
	--assert b-pointer2/value = #"h"

	--test-- "pointer-rw-16"
		p-struct16: declare struct! [n [integer!] m [integer!]]
		prw16: declare pointer! [integer!]
		prw16: as pointer! [integer!] p-struct16
		prw16/value: 789

		pp: declare pointer! [pointer!]
		pp: :prw16
		np16: as pointer! [integer!] pp/value
		--assert np16/value = 789

===end-group===

===start-group=== "Pointers arithmetic"
	
	--test-- "pointer-calc-1"
	pa-struct: declare struct! [n [integer!] m [integer!] p [integer!] o [integer!]]
	pA: declare pointer! [integer!]
	pB: declare pointer! [integer!]
	
	pA: as [pointer! [integer!]] pa-struct
	pa-struct/n: 123456789
	pa-struct/m: 987654321
	--assert pA/value = 123456789
	
	--test-- "pointer-calc-2"
	pA: pA + 1
	--assert pA/value = 987654321
	
	--test-- "pointer-calc-3"
	pa-struct/o: 123
	pA: pA + 2
	--assert pA/value = 123
	
	--test-- "pointer-calc-4"
	pA: pA - 3
	--assert pA/value = 123456789
	
	--test-- "pointer-calc-5"
	pointer-idx: 3
	pA: pA + pointer-idx
	--assert pA/value = 123
	
	--test-- "pointer-calc-6"
	pointer-idx: -3
	pA: pA + pointer-idx
	--assert pA/value = 123456789
	
	--test-- "pointer-calc-7"
	pA: pA - pointer-idx
	--assert pA/value = 123
	
	--test-- "pointer-calc-8"
	b-pointer: b-pointer + 1
	--assert b-pointer/value = #"e"
	pointer-idx: 2
	b-pointer: b-pointer + pointer-idx
	--assert b-pointer/value = #"l"
	
	--test-- "pointer-calc-9" 
	pA: as [pointer! [integer!]] pa-struct
	--assert pA/1 = 123456789
	--assert pA/2 = 987654321
	
	--test-- "pointer-calc-10" 
	pointer-idx: 1
	--assert pA/pointer-idx = 123456789
	
	--test-- "pointer-calc-11" 
	pointer-idx: 2
	--assert pA/pointer-idx = 987654321
	
	--test-- "pointer-calc-12" 
	pointer-idx: 4
	--assert pA/pointer-idx = 123

	--test-- "pointer-calc-13" 
		ppc: declare pointer! [pointer!]
		ppc: as pointer! [pointer!] :pA
		--assert ppc/1 = pA 
		--assert ppc/3 = pB 			;-- pB follows pA in memory, skipping pA's value slot
	
===end-group===

===start-group=== "Local pointers simple read/write tests"

pointer-local-foo: func [
	/local
		p-struct [struct! [n [integer!] m [integer!]]]
		p-struct16 [struct! [n [integer!] m [integer!]]]
		pA 		 [pointer! [integer!]]
		pB 		 [pointer! [integer!]]
		p-int    [integer!]
		p-idx    [integer!]
		pointer-str [struct! [
			A [pointer! [integer!]]
			B [pointer! [integer!]]
			sub [struct! [C [pointer! [integer!]]]]
		]]
		pa-struct [struct! [n [integer!] m [integer!] p [integer!] o [integer!]]]
		b-pointer [pointer! [byte!]]
		b-str	[c-string!]
		pointer-idx [integer!]
		pp		[pointer! [pointer!]]
		prw16   [pointer! [integer!]]
		np16 	[pointer! [integer!]]
][

	--test-- "loc-point-rw-1"
	p-struct: declare struct! [n [integer!] m [integer!]]
	p-struct/n: 123
	--assert p-struct/n = 123

	--test-- "loc-point-rw-2"
	pA: as [pointer! [integer!]] p-struct
	pA/value: 987
	--assert p-struct/n = 987
	pA/1: 987
	--assert p-struct/n = 987

	--test-- "loc-point-rw-3"
	p-struct/n: 12345
	--assert pA/value = 12345
	--assert pA/1 = 12345

	--test-- "loc-point-rw-4"
	p-int: 456789
	pA/2: p-int
	--assert p-struct/m = p-int
	--assert p-struct/n = 12345			;-- look for memory corruption

	--test-- "loc-point-rw-5"
	p-idx: 1
	pA/p-idx: 369
	--assert p-struct/n = 369

	--test-- "loc-point-rw-6"
	p-idx: 2
	pA/p-idx: 963
	--assert p-struct/m = 963

	--test-- "loc-point-rw-7"
	p-struct/n: 12345
	p-int: 147258
	p-struct/m: p-int
	--assert pA/2 = p-int
	--assert p-struct/n = 12345			;-- look for memory corruption

	--test-- "loc-point-rw-8"
	pB: pA
	--assert pB/value = 12345

	--test-- "loc-point-rw-9"
	pB: foo-pointer pA 
	--assert pB/value = 12345

	pointer-str: declare struct! [
		A [pointer! [integer!]]
		B [pointer! [integer!]]
		sub [
			struct! [
				C [pointer! [integer!]]
			]
		]
	]
	pointer-str/sub: declare struct! [C [pointer! [integer!]]]

	--test-- "loc-point-rw-10"
	pointer-str/A: pA
	--assert pointer-str/A/value = 12345

	--test-- "loc-point-rw-11"
	pointer-str/A/value: 258369147
	--assert p-struct/n = 258369147
	--assert p-struct/m = p-int				;-- look for memory corruption			

	--test-- "loc-point-rw-12"
	pointer-str/sub/C: pA
	--assert pointer-str/sub/C/value = 258369147

	--test-- "loc-point-rw-13"
	pointer-str/sub/C/2: 987654321
	--assert p-struct/m = 987654321
	
	--test-- "loc-point-rw-14"
	b-pointer: declare pointer! [byte!]
	b-str: "hello"
	b-pointer: as [pointer! [byte!]] b-str
	--assert b-pointer/value = #"h"

	--test-- "loc-point-rw-15"
	b-pointer2: declare pointer! [byte!]
	b-pointer2: foo-b-pointer b-pointer
	--assert b-pointer2/value = #"h"

	--test-- "loc-pointer-rw-16"
		p-struct16: declare struct! [n [integer!] m [integer!]]
		prw16: as pointer! [integer!] p-struct16
		prw16/value: 789
		pp: :prw16
		np16: as pointer! [integer!] pp/value
		--assert np16/value = 789
	
	--test-- "loc-point-calc-1"
	pa-struct: declare struct! [n [integer!] m [integer!] p [integer!] o [integer!]]

	pA: as [pointer! [integer!]] pa-struct
	pa-struct/n: 123456789
	pa-struct/m: 987654321
	--assert pA/value = 123456789

	--test-- "loc-point-calc-2"
	pA: pA + 1
	--assert pA/value = 987654321

	--test-- "loc-point-calc-3"
	pa-struct/o: 123
	pA: pA + 2
	--assert pA/value = 123

	--test-- "loc-point-calc-4"
	pA: pA - 3
	--assert pA/value = 123456789

	--test-- "loc-point-calc-5"
	p-idx: 3
	pA: pA + p-idx
	--assert pA/value = 123
	
	--test-- "loc-point-calc-6"
	p-idx: -3
	pA: pA + p-idx
	--assert pA/value = 123456789
	
	--test-- "loc-point-calc-7"
	pA: pA - p-idx
	--assert pA/value = 123
	
	--test-- "loc-point-calc-8"
	b-pointer: b-pointer + 1
	--assert b-pointer/value = #"e"
	pointer-idx: 2
	b-pointer: b-pointer + pointer-idx
	--assert b-pointer/value = #"l"
	
	--test-- "loc-point-calc-9" 
	pA: as [pointer! [integer!]] pa-struct
	--assert pA/1 = 123456789
	--assert pA/2 = 987654321

	--test-- "loc-point-calc-10" 
	pointer-idx: 1
	--assert pA/pointer-idx = 123456789

	--test-- "loc-point-calc-11" 
	pointer-idx: 2
	--assert pA/pointer-idx = 987654321

	--test-- "loc-point-calc-12" 
	pointer-idx: 4
	--assert pA/pointer-idx = 123

	--test-- "loc-pointer-calc-13" 
		ppc: as pointer! [pointer!] :pA	
		--assert ppc/value = pA 
		ppc: ppc - 1
		--assert ppc/value = pB 			;-- pB is below pA on stack
]
pointer-local-foo

===end-group===

===start-group=== "Issues"

	--test-- "#4103"
	    s4103!: alias struct! [
	        header [integer!] 
	        data1 [integer!] 
	        data2 [integer!] 
	        data3 [integer!]
	    ] 
		p: as s4103! 00100000h
		--assert (as s4103! 00100010h) = (p + 1)
		--assert (as byte-ptr! 00100000h) = as byte-ptr! (as-integer p)
		;--assert (as byte-ptr! 00100010h) = as byte-ptr! (as-integer (p + 1))
		p: p + 1
		i4103: as-integer p	
		--assert 00100010h = i4103
		b4103: as byte-ptr! i4103
		--assert (as byte-ptr! 00100010h) = b4103
		
		;--assert #"A" = as-byte as-integer #"A"
		;--assert 66 = as-integer as-byte 66

	--test-- "#4414"
		head: as byte-ptr! DEADBEEFh
		--assert head = as byte-ptr! head ; ignore compiler's warning
		--assert head = as byte-ptr! as int-ptr! head

===end-group===

~~~end-file~~~