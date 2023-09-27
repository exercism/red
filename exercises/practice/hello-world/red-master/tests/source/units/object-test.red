Red [
	Title:   "Red/System object! datatype test script"
	Author:  "Nenad Rakocevic & Peter W A Wood"
	File: 	 %object-test.red
	Version: "0.1.0"
	Tabs:	 4
	Rights:  "Copyright (C) 2011-2015 Red Foundation. All rights reserved."
	License: "BSD-3 - https://github.com/red/red/blob/origin/BSD-3-License.txt"
]

#include  %../../../quick-test/quick-test.red

~~~start-file~~~ "object"

===start-group=== "reactor tests"

    --test-- "reactor-basic-1"
        rb1-r: make reactor! [
            x: 1
            y: 2
            total: is [x + y]
        ]
        --assert 3 = rb1-r/total
        rb1-r/x: 2
        --assert 4 = rb1-r/total
        rb1-r/x: 5
        rb1-r/y: 10
        --assert 15 = rb1-r/total
        
===end-group===

===start-group=== "basic tests"

	--test-- "basic-1"
		obj1: context []
		--assert "make object! []" = mold obj1

	--test-- "basic-2"
		obj2: object []
		--assert "make object! []" = mold obj2
		
	--test-- "basic-3"
		obj3: make object! []
		--assert "make object! []" = mold obj3
	
	--test-- "basic-4"
		blk: []
		obj4: object blk
		--assert "make object! []" = mold obj4
	
	--test-- "basic-5"
		obj5: object [
			a: 123
			show: does [a + 1]
			reset: does [a: none]
			--assert show = 124
			--assert a = 123
		]
		--assert obj5/show = 124
		obj5/reset
		--assert none? obj5/a

	--test-- "basic-6"
		obj5/a: 456
		--assert obj5/a = 456

	--test-- "basic-7"
		;; DEPRECATED
		;;--assert find obj5 'a
		;;--assert not find obj5 'z
		--assert 456 = select obj5 'a
		--assert none? select obj5 'z

	--test-- "basic-8"
		obj8: context [
			b: 123
			a: object [
				b: 456
				double: does [b * 2]
				set-b: does [b: 'hello]
			]
		]
		--assert obj8/b = 123
		--assert obj8/a/b = 456
		--assert obj8/a/double = 912
		obj8/a/set-b
		--assert obj8/a/b = 'hello

	--test-- "basic-9"
		obj8/a/b: 'red
		--assert obj8/a/b = 'red

	--test-- "basic-10"
		obj10: object [
			a: 1
			b: 2
			inc: func [i /with a][b: i + either with [a][b]]
			sub: context [
				a: 3
				b: 4
				inc: func [i /with a][b: i + either with [a][b]]
			]
		]
		--assert 12 = obj10/inc 10
		--assert obj10/b = 12

		--assert 14 = obj10/sub/inc 10
		--assert obj10/sub/b = 14

	--test-- "basic-11"
		--assert 30 = obj10/inc/with 10 20
		--assert obj10/b = 30

		--assert 50 = obj10/sub/inc/with 10 40
		--assert obj10/sub/b = 50

	--test-- "basic-12"
		blk: [a: 99]
		obj12: object blk
		--assert obj12/a = 99
	
	--test-- "basic-13"
		b13-a: 0
		b13-o: make object! [
			b13-a: 0
		]
		set in b13-o 'b13-a 1
		--assert 0 == b13-a
		--assert 1 == b13-o/b13-a

===end-group===


===start-group=== "Comparison tests"

	--test-- "comp-1"  --assert 	(context [])	 = (context [])
	--test-- "comp-2"  --assert not (context [a: 1]) = (context [])
	--test-- "comp-3"  --assert 	(context [a: 1]) = (context [a: 1])
	--test-- "comp-4"  --assert not (context [a: 1]) = (context [a: 2])
	--test-- "comp-5"  --assert 	(context [a: 1]) < (context [a: 2])
	--test-- "comp-6"  --assert not (context [a: 1]) >= (context [a: 2])
	--test-- "comp-7"  --assert 	(context [a: 2]) < (context [a: 1 b: none])

	--test-- "comp-8"
		obj:  context [a: 123]
		obj2: context [a: 123]
		--assert obj = obj2
		--assert not same? obj obj2
		--assert same? obj obj

===end-group===

===start-group=== "SELF test"

	--test-- "self-1"
		obj: context [
			--assert "make object! []" = mold/flat self
		]

	--test-- "self-2"
		obj: context [
			a: 123
			--assert "make object! [a: 123 b: unset]" = mold/flat self
			b: 456
		]

	--test-- "self-3"
		result: {make object! [b: 123 c: "hello" show: func [][--assert object? self] foo: unset]}
		
		obj: object [
			b: 123
			c: "hello"
			show: does [--assert object? self]
			--assert result = mold/flat self
			foo: does [--assert object? self c: none]
			foo
		]
		obj/show
		--assert none? obj/c

	--test-- "self-4"
		p1: object [
		    a: 1
		    b: 2
		    e: does [self/b]
		    f: does [self/b: 789 self/e]
		    --assert self/e = 2
		]
		--assert p1/e = 2
		--assert p1/f = 789

===end-group===

===start-group=== "simple object tests"
	
	--test-- "simple object 1"
		so1-a: 0
		so1-o: make object! [so1-a: 1]
		--assert so1-a = 0
		--assert so1-o/so1-a = 1
		
	--test-- "simple object 2"
		so2-s: "0"
		so2-o: make object! [so2-s: "1"]
		--assert so2-s = "0"
		--assert so2-o/so2-s = "1"
		
	--test-- "simple object 3"
		so3-s: "0"
		so3-i: 0
		so3-l: true
		so3-c: #"a"
		so3-b: [a b c]
		so3-f: func [][0]
		so3-bs: charset #"^(00)"
		so3-o: make object! [
			so3-s: "1"
			so3-i: 1
			so3-l: false
			so3-c: #"b"
			so3-b: [a b d]
			so3-f: func [][1]
			so3-bs: charset #"^(01)"
		]
		--assert so3-s = "0"
		--assert so3-o/so3-s = "1"
		--assert so3-i = 0
		--assert so3-o/so3-i = 1
		--assert so3-l = true
		--assert so3-o/so3-l = false
		--assert so3-c = #"a"
		--assert so3-o/so3-c = #"b"
		--assert so3-b = [a b c]
		--assert so3-o/so3-b = [a b d]
		--assert so3-f = 0
		--assert so3-o/so3-f = 1
		--assert "make bitset! #{80}" = mold so3-bs
		--assert "make bitset! #{40}" = mold so3-o/so3-bs
		
===end-group===

===start-group=== "nested objects"

	--test-- "no1"
		no1-o: make object! [o: make object! [i: 1] ]
		--assert no1-o/o/i = 1
		
	--test-- "no2"
		no2-o1: make object! [
			o2: make object! [
				i: 1
			]
		]
		--assert no2-o1/o2/i = 1
		
	--test-- "no3"
		no3-o1: make object! [
			o2: make object! [
			o3: make object! [
			o4: make object! [
				i: 1
			]]]
		]
		--assert no3-o1/o2/o3/o4/i = 1

	--test-- "no4"
		no4-o1: make object! [
			o2: make object! [
			o3: make object! [
			o4: make object! [
			o5: make object! [
			o6: make object! [
			o7: make object! [
				i: 1
			]]]]]]
		]
		--assert no4-o1/o2/o3/o4/o5/o6/o7/i = 1
	
	--test-- "no5"
		no5-o1: make object! [
			o2: make object! [
			o3: make object! [
			o4: make object! [
			o5: make object! [
			o6: make object! [
			o7: make object! [
			o8: make object! [
			o9: make object! [
			o10: make object! [
			o11: make object! [
			o12: make object! [
			o13: make object! [
			;o14: make object! [
			;o15: make object! [
				i: 1
			]]]]]]]]]]]];]]
		]
		;--assert no5-o1/o2/o3/o4/o5/o6/o7/o8/o9/o10/o11/o12/o13/o14/o15/i = 1 
		--assert no5-o1/o2/o3/o4/o5/o6/o7/o8/o9/o10/o11/o12/o13/i = 1
		
	--test-- "no6 issue #928"
		no6-o: make object! [
			a: 1
			o: make object! [
				b: 2
				f: does [a]
				]
			]
		--assert 1 = no6-o/o/f
		
	--test-- "no7"
		no7-a: 1
		no7-o: make object! [
			no7-a: 2
			f: func[][no7-a]
		]
		--assert 2 = no7-o/f
		
	--test-- "no8"
		no8-a: 1
		no8-o: make object! [
			no8-a: 2
			oo: make object! [
				no8-a: 3
				f: func[][no8-a]
			]
		]
		--assert 3 = no8-o/oo/f
		
===end-group===

===start-group=== "object prototype tests"

	--test-- "op1"
		op1-o1: make object! [i: 1]
		op1-o2: make op1-o1 []
		--assert op1-o2/i = 1
		
	--test-- "op2"
		op2-o1: make object! [i: 1]
		op2-o2: make op2-o1 [i: 2]
		--assert op2-o2/i = 2
		--assert op2-o1/i = 1

	--test-- "op3"
		op3-o1: make object! [i: 1]
		op3-o2: make op3-o1 [i: 2 j: 3]
		--assert op3-o2/i = 2
		--assert op3-o2/j = 3
		
===end-group===

===start-group=== "object initialisation processing"

	--test-- "oip1"
		oip1-i: 1
		oip1-o: make object! [
			i: oip1-i
		]
		--assert 1 = oip1-o/i
		
	--test-- "oip2"
		oip2-i: 1
		oip2-o: make object! [
			i: either oip2-i = 1 [2] [3]
		]
		--assert 2 = oip2-o/i
	
	--test-- "oip3"
		oip3-i: 1
		oip3-o: make object! [
			i: 0
			set 'oip3-i 2
		]
		--assert 2 = oip3-i
		
	--test-- "oip4"
		oip4-o: make object! [
			i: 0
			set 'oip4-i 3
		]
		--assert 3 = oip4-i


===end-group===

===start-group=== "inheritance"

	--test-- "inherit-1"
		proto: context [
			a: 123
			get-a: does [a]
		]
		new: make proto [a: 99]
		--assert new/a = 99
		--assert new/get-a = 99
		--assert proto/a = 123
		--assert proto/get-a = 123

	--test-- "inherit-2"
		new/a: 456
		--assert new/get-a = 456
		proto/a: 759
		--assert proto/a = 759
		--assert new/get-a = 456

	--test-- "inherit-3"
		newnew: make new [
			reset: does [a: none]
		]
		--assert newnew/a = 456
		newnew/reset
		--assert none? newnew/a
		--assert new/a = 456
		--assert proto/a = 759

	--test-- "inherit-4"
		base: context [
			v: 0
			foo: does [v]
		]

		i: 0
		list: []
		loop 2 [
			bb: make base [v: i]
			--assert bb/foo = i
			append list bb
			i: i + 1
		]
		--assert object? list/1
		--assert list/1/v = 0
		--assert list/2/v = 1

#if config/dev-mode? = no [							;-- libRedRT does not support multiple-inheritance
	--test-- "inherit-5"
		base5: context [
			b: 123
			get-b: does [b]
			a: object [
				b: 456
				double: does [b * 2]
				set-b: func [/with v] [b: either with [v]['hello]]
			]
		]
		proto5: context [
			b: 999
			value: 71
			foo: does [b + value]
		]
		new: make base5 proto5
		--assert object? new
		--assert new/b = 999
		--assert new/value = 71
		--assert new/a/b = 456
		--assert base5/b = 123

	--test-- "inherit-6"
		--assert new/get-b = 999
		--assert new/a/double = 912
		new/a/set-b/with 10
		--assert new/a/b = 10
		--assert new/b = 999
		--assert base5/b = 123
		--assert new/a/double = 20
		--assert base5/a/double = 20

	--test-- "inherit-7"
		--assert same? new/a base5/a

	--test-- "inherit-8"
		--assert new/foo = 1070
]
	--test-- "inherit-9"
		base9: context [
			v: 123456
			show: does [v]
		]
		i: 100
		list: []
		loop 3 [
			new9: make base9 [v: i]
			--assert new9/v = i
			--assert new9/show = i
			append list new9
			i: i + 1
		]
		--assert base9/v = 123456
		--assert list/1/v = 100
		--assert list/2/v = 101
		--assert list/3/v = 102
		
	--test-- "inherit-10"
		base10: make object! [
			oo: make object! [
				a: 1
			]
		]
		new10: make base10 []
		base10/oo/a: 9
		--assert 9 = new10/oo/a
		
	--test-- "inherit-11"
		base11: make object! [
			a: 1
			oo: make object! [
				f: func [][a]
			]
		]
		new11: make base11 [a: 2]
		--assert 1 = new11/oo/f

===end-group===

===start-group=== "external deep setting"

	--test-- "ext-1"
		p1: object [
		    a: 1
		    b: 2
		]

		p1/a: context [
			t: 99
			z: 128
			q: object [zz: 345 show: does [zz]]
		]
		--assert object? p1/a
		--assert p1/a/z = 128
		--assert p1/a/q/show = 345

	--test-- "ext-2"
		p1/a/t: does [123]
		--assert p1/a/t = 123

===end-group===

===start-group=== "dynamic invocation"

	--test-- "dyn-1"
		d: context [
			value: 998
		    f: does [value]
		]
		h: :d/f
		--assert h = 998
		d/value: 123
		--assert 123 = do [h]


	--test-- "dyn-2"
		f: func [/local z][
		    z: object [
		        a: 1
		        g: func [/with b /local c][c: 10 either with [a + b + 10][a * 2]]
		        j: func [i][i + 1]
		    ]
	    	z
		]
		o: make f [a: 3]
		--assert 46 = do [o/j 45]			;@@ temporary workaround until dyn-stack branch
		--assert 101 = do [o/j 100]			;@@ temporary workaround until dyn-stack branch

	--test-- "dyn-3"
		--assert 52 = do [o/j o/j 50]		;@@ temporary workaround until dyn-stack branch

	--test-- "dyn-4"
		--assert 33 = do [o/g/with 20]		;@@ temporary workaround until dyn-stack branch
		--assert 59 = do [o/g/with o/j 45]	;@@ temporary workaround until dyn-stack branch

	--test-- "dyn-5"
		z: none
		--assert 12 = do [o/j z: 5 + 6]		;@@ temporary workaround until dyn-stack branch
		--assert  z = 11

	--test-- "dyn-6"
		--assert [17] = reduce [do [o/j o/j z: 5 + 10]] ;@@ temporary workaround until dyn-stack branch
		--assert z = 15

	--test-- "dyn-7"
		repeat c 1 [
			if yes [
				--assert 52 = do [o/j o/j 50]
				--assert 59 = do [o/g/with o/j 45]
				--assert [22] = reduce [do [o/j o/j z: 5 + 15]] ;@@ temporary workaround until dyn-stack branch
				--assert z = 20
			]
		]

	--test-- "dyn-8"
		o2: context [zz: none]				;-- test renaming a statically compiled object

		f: func [/alt][
			either alt [
				make object! [
					a: 10
					g: 123
				]
			][
				make object! [
					a: 1
					g: does [a]
				]
			]
		]
		o2: f
		--assert 1 = do [o2/g] 				;@@ temporary workaround until dyn-stack branch

	--test-- "dyn-9"
		o2: f/alt
		--assert 123 = do [o2/g]			;@@ temporary workaround until dyn-stack branch

	--test-- "dyn-10"

		o: context [a: [123 789]]
		--assert if o/a [true]
		--assert if block? o/a [true]
		--assert if 123 = first o/a [true]

	--test-- "dyn-11"
		--assert either o/a [true][false]
		--assert either block? o/a [true][false]
		--assert either 789 = second o/a [true][false]

	--test-- "dyn-12"
		--assert block? all [o/a]
		--assert not 	all [false o/a]
		--assert not 	all [o/a false]
		--assert 456 = 	all [o/a 456]

	--test-- "dyn-13"
		--assert block? any [o/a 0]
		--assert block? any [false o/a]
		--assert block? any [o/a false]
		--assert block? any [o/a 456]
		--assert 654 =  any [654 o/a]

	--test-- "dyn-14"
		foreach p o/a [--assert any [p = 123 p = 789]]

	--test-- "dyn-15"
		loop length? o/a [--assert any [p = 123 p = 789]]

	--test-- "dyn-16"
		repeat c length? o/a [--assert any [c = 1 c = 2]]

	--test-- "dyn-17"
		repeat c 125 - first o/a [--assert any [c = 1 c = 2]]

	--test-- "dyn-18"
		switch/default first o/a [
			123 [
				--assert true
				switch/default second o/a [
					789 [--assert true]
				][--assert false]
			]
			789 [--assert false]
		][--assert false]

	--test-- "dyn-19"
		 --assert 0 < first o/a

	--test-- "dyn-20"
		case [
			first o/a  	[--assert true]
			'else 		[--assert false]
		]

	--test-- "dyn-21"
		case [
			0 < first o/a [--assert true]
			'else	  	  [--assert false]
		]

	--test-- "dyn-22"
		case [
			0 = first o/a 	  [--assert false]
			789 = second o/a  [--assert true]
		]

	--test-- "dyn-23"
		c: context [
			x: 1
			f: func [o [object!]][x: do [o/a]]	;@@ temporary workaround until dyn-stack branch
		]

		c/f object [a: 123]
		--assert c/x = 123

		c/f object [a: does [99]]
		--assert c/x = 99

	--test-- "dyn-24"						;; issue #965
		o: [a "hello" b " world"]
		--assert "hello" = o/a
		--assert "hello world" = append o/a o/b
		--assert "hello world123" = append o/a 123 o/b

	--test-- "dyn-25"
		o: context [
			a: func [v][v * 2]
			b: 123
		]
		--assert 143 = add o/a 10 o/b
		--assert 256 = add o/a o/b 10

	--test-- "dyn-26"						;; issue #990
		f-obj-switch: func [
		    o [object!]
		][
		    switch type?/word o/x [
		        integer! [-1]
		    ]
		]
		--assert -1 = f-obj-switch object [x: 0]

===end-group===

===start-group=== "copy"
	
	--test-- "copy-1"
		co1: make object! [a: 1]
		co2: copy co1
		co1/a: 2
		--assert 2 = co1/a
		--assert 1 = co2/a
	
	--test-- "copy-2"
		co1: make object! [
			a: 1
			f: func[][a]
		]
		co2: copy co1
		co1/a: 2
		--assert 2 = co1/f
		--assert 1 = do [co2/f]		;@@ temporary workaround until dyn-stack branch
		
	--test-- "copy-3"
		co1: make object! [
			a: 1
			b: 2
			blk: [1 2 3 4]
		]
		co2: copy co1
		co1/blk/1: 5
		--assert 5 = co1/blk/1 
		--assert 5 = co2/blk/1
		
	--test-- "copy-4"
		co1: make object! [
			a: 1
			b: 2
			blk: [1 2 3 4]
		]
		co2: copy/deep co1
		co1/blk/1: 5
		--assert 5 = co1/blk/1 
		--assert 1 = co2/blk/1
		
	--test-- "copy-5"
		co1: make object! [
			a: 1
			s: "Silly old string"
			f: func [][
				[s a]
			]
		]
		co2: copy co1
		co1/a: 5
		co1/s/2: #"h"
		co1/s/3: #"i"
		co1/s/4: #"n"
		--assert "Shiny old string" = co1/s
		--assert "Shiny old string" = co2/s
		
	--test-- "copy-6"
		co1: make object! [
			a: 1
			s: "Silly old string"
		]
		co2: copy co1
		co1/a: 5
		co1/s/2: #"h"
		co1/s/3: #"i"
		co1/s/4: #"n"
		replace co1/s "old" "new"
		--assert "Shiny new string" = co1/s
		--assert "Shiny new string" = co2/s
		
	--test-- "copy-7"
		co5: make object! [
			a: 1
			s: "Silly old string"
		]
		co6: copy/deep co5
		co5/a: 5
		co5/s/2: #"h"
		co5/s/3: #"i"
		co5/s/4: #"n"
		replace at co5/s 7 "old" "new"
		--assert "Shiny new string" = co5/s
		--assert "Silly old string" = co6/s
		
	--test-- "copy-8"
		co1: make object! [
			s: "Silly old string"
			f: func[][s]
		]
		co2: copy co1
		co1/s/2: #"h"
		co1/s/3: #"i"
		co1/s/4: #"n"
		replace co1/s "old" "new"
		--assert "Shiny new string" = co1/f
		--assert "Shiny new string" = do [co2/f] ;@@ temporary workaround until dyn-stack branch
		
	--test-- "copy-9"
		co1: make object! [
			s: "Silly old string"
			f: func[][s]
		]
		co2: copy/deep co1
		co1/s/2: #"h"
		co1/s/3: #"i"
		co1/s/4: #"n"
		replace co1/s "old" "new"
		--assert "Shiny new string" = co1/f
		--assert "Silly old string" = do [co2/f]  ;@@ temporary workaround until dyn-stack branch
	
	--test-- "copy-10"
		co1: make object! [
			a: 1
			f: func[][a]
		]
		co2: copy/deep co1
		co1/a: 2
		--assert 2 = co1/f
		--assert 1 = do [co2/f]			;@@ temporary workaround until dyn-stack branch
		
	--test-- "copy-11"
		co1: make object! [
			a: 1
			oo: make object! [
				f: func[][a]
			]
		]
		co2: copy/deep co1
		co1/a: 2
		--assert 2 = co1/oo/f
		--assert 2 = do [co2/oo/f]		;@@ temporary workaround until dyn-stack branch
		
	--test-- "copy-12"
		co1: make object! [
			a: 1
			oo: make object! [
				f: func[][a]
			]
		]
		co2: copy/deep co1
		co1/a: 2
		--assert 2 = co1/oo/f
		--assert 2 = do [co2/oo/f]		;@@ temporary workaround until dyn-stack branch
		
===end-group===

===start-group=== "in"

	--test-- "in1"
		ino1: make object! [
			i: 1
			c: #"a"
			f: 1.0
			b: [1 2 3 4]
			s: "abcdef"
			o: make object! [
			]
		]
		--assert 'i = in ino1 'i
		--assert 'c = in ino1 'c
		--assert 'b = in ino1 'b
		--assert 'f = in ino1 'f
		--assert 's = in ino1 's
		--assert 'o = in ino1 'o
		

	--test-- "in2"
		ino1: make object! [
			i: 1
			c: #"a"
			f: 1.0
			b: [1 2 3 4]
			s: "abcdef"
			o: make object! [
				c: #"b"
				i: 2
				f: 2.0
				b: [5 6 7 8]
				s: "ghijkl"
				o: make object! [
				]
			]
		]
		--assert 'i = in ino1 'i
		--assert 'c = in ino1 'c
		--assert 'b = in ino1 'b
		--assert 'f = in ino1 'f
		--assert 's = in ino1 's
		--assert 'o = in ino1 'o
		--assert 'i = in ino1/o 'i
		--assert 'c = in ino1/o 'c
		--assert 'b = in ino1/o 'b
		--assert 'f = in ino1/o 'f
		--assert 's = in ino1/o 's
		--assert 'o = in ino1/o 'o


	--test-- "in3"
		ino1: make object! [
			i: 1
			c: #"a"
			f: 1.0
			b: [1 2 3 4]
			s: "abcdef"
			o: make object! [
				c: #"b"
				i: 2
				f: 2.0
				b: [5 6 7 8]
				s: "ghijkl"
				o: make object! [
					c: #"c"
					i: 3
					f: 3.0
					b: [9 10 11 12]
					s: "mnopqr"
					o: make object! [
					]
				]
			]
		]
		--assert 'i = in ino1 'i
		--assert 'c = in ino1 'c
		--assert 'b = in ino1 'b
		--assert 'f = in ino1 'f
		--assert 's = in ino1 's
		--assert 'o = in ino1 'o
		--assert 'i = in ino1/o 'i
		--assert 'c = in ino1/o 'c
		--assert 'b = in ino1/o 'b
		--assert 'f = in ino1/o 'f
		--assert 's = in ino1/o 's
		--assert 'o = in ino1/o 'o
		--assert 'i = in ino1/o/o 'i
		--assert 'c = in ino1/o/o 'c
		--assert 'b = in ino1/o/o 'b
		--assert 'f = in ino1/o/o 'f
		--assert 's = in ino1/o/o 's
		--assert 'o = in ino1/o/o 'o

	--test-- "in4"
		ino1: make object! [
			i: 1
			c: #"a"
			f: 1.0
			b: [1 2 3 4]
			s: "abcdef"
			o: make object! [
				c: #"b"
				i: 2
				f: 2.0
				b: [5 6 7 8]
				s: "ghijkl"
				o: make object! [
					c: #"c"
					i: 3
					f: 3.0
					b: [9 10 11 12]
					s: "mnopqr"
					o: make object! [
						c: #"d"
						f: 4.0
						i: 4
						b: [13 14 15 16]
						s: "stuvwx"
					]
				]
			]
		]
		--assert 'i = in ino1 'i
		--assert 'c = in ino1 'c
		--assert 'b = in ino1 'b
		--assert 'f = in ino1 'f
		--assert 's = in ino1 's
		--assert 'o = in ino1 'o
		--assert 'i = in ino1/o 'i
		--assert 'c = in ino1/o 'c
		--assert 'b = in ino1/o 'b
		--assert 'f = in ino1/o 'f
		--assert 's = in ino1/o 's
		--assert 'o = in ino1/o 'o
		--assert 'i = in ino1/o/o 'i
		--assert 'c = in ino1/o/o 'c
		--assert 'b = in ino1/o/o 'b
		--assert 'f = in ino1/o/o 'f
		--assert 's = in ino1/o/o 's
		--assert 'o = in ino1/o/o 'o
		--assert 'i = in ino1/o/o/o 'i
		--assert 'c = in ino1/o/o/o 'c
		--assert 'b = in ino1/o/o/o 'b
		--assert 'f = in ino1/o/o/o 'f
		--assert 's = in ino1/o/o/o 's
		
	--test-- "in5"
		a: 0
		in5-f: func[] [make object! [a: 1]]
		--assert 1 = get in in5-f 'a	
	
===end-group===


===start-group=== "local objects"

	f-make-obj-1: func [/local z][
	    z: object [
	        a: 1
	        g: func [/with b /local q][q: 10 either with [a + b + 10][a * 2]]
	        j: func [i][i + 1]
	    ]
		z
	]

	f-make-obj-2: func [/alt][
		either alt [
			make object! [
				a: 10
				g: 123
			]
		][
			make object! [
				a: 1
				g: does [a]
			]
		]
	]

	so3-f: func [][0]

	local-obj-fun: function [/extern so3-f][

		--test-- "loc-basic-1"
			obj1: context []
			--assert "make object! []" = mold obj1

		--test-- "loc-basic-2"
			obj2: object []
			--assert "make object! []" = mold obj2
			
		--test-- "loc-basic-3"
			obj3: make object! []
			--assert "make object! []" = mold obj3
		
		--test-- "loc-basic-4"
			blk: []
			obj4: object blk
			--assert "make object! []" = mold obj4
		
		--test-- "loc-basic-5"
			obj5: object [
				a: 123
				show: does [a + 1]
				reset: does [a: none]
				--assert show = 124
				--assert a = 123
			]
			--assert obj5/show = 124
			obj5/reset
			--assert none? obj5/a

		--test-- "loc-basic-6"
			obj5/a: 456
			--assert obj5/a = 456

		--test-- "loc-basic-7"
			;; DEPRECATED
			;;--assert find obj5 'a
			;;--assert not find obj5 'z
			--assert 456 = select obj5 'a
			--assert none? select obj5 'z

		--test-- "loc-basic-8"
			obj8: context [
				b: 123
				a: object [
					b: 456
					double: does [b * 2]
					set-b: does [b: 'hello]
				]
			]
			--assert obj8/b = 123
			--assert obj8/a/b = 456
			--assert obj8/a/double = 912
			obj8/a/set-b
			--assert obj8/a/b = 'hello

		--test-- "loc-basic-9"
			obj8/a/b: 'red
			--assert obj8/a/b = 'red

		--test-- "loc-basic-10"
			obj10: object [
				a: 1
				b: 2
				inc: func [i /with a][b: i + either with [a][b]]
				sub: context [
					a: 3
					b: 4
					inc: func [i /with a][b: i + either with [a][b]]
				]
			]
			--assert 12 = obj10/inc 10
			--assert obj10/b = 12

			--assert 14 = obj10/sub/inc 10
			--assert obj10/sub/b = 14

		--test-- "loc-basic-11"
			--assert 30 = obj10/inc/with 10 20
			--assert obj10/b = 30

			--assert 50 = obj10/sub/inc/with 10 40
			--assert obj10/sub/b = 50

		--test-- "loc-basic-12"
			blk: [a: 99]
			obj12: object blk
			--assert obj12/a = 99


		--test-- "loc-comp-1"  --assert 	(context [])	 = (context [])
		--test-- "loc-comp-2"  --assert not (context [a: 1]) = (context [])
		--test-- "loc-comp-3"  --assert 	(context [a: 1]) = (context [a: 1])
		--test-- "loc-comp-4"  --assert not (context [a: 1]) = (context [a: 2])
		--test-- "loc-comp-5"  --assert 	(context [a: 1]) < (context [a: 2])
		--test-- "loc-comp-6"  --assert not (context [a: 1]) >= (context [a: 2])
		--test-- "loc-comp-7"  --assert 	(context [a: 2]) < (context [a: 1 b: none])

		--test-- "loc-comp-8"
			obj:  context [a: 123]
			obj2: context [a: 123]
			--assert obj = obj2
			--assert not same? obj obj2
			--assert same? obj obj


		--test-- "loc-self-1"
			obj: context [
				--assert "make object! []" = mold/flat self
			]

		--test-- "loc-self-2"
			obj: context [
				a: 123
				--assert "make object! [a: 123 b: unset]" = mold/flat self
				b: 456
			]

		--test-- "loc-self-3"
			result: {make object! [b: 123 c: "hello" show: func [][--assert object? self] foo: unset]}
			
			obj: object [
				b: 123
				c: "hello"
				show: does [--assert object? self]
				--assert result = mold/flat self
				foo: does [--assert object? self c: none]
				foo
			]
			obj/show
			--assert none? obj/c

		--test-- "loc-self-4"
			p1: object [
			    a: 1
			    b: 2
			    e: does [self/b]
			    f: does [self/b: 789 self/e]
			    --assert self/e = 2
			]
			--assert p1/e = 2
			--assert p1/f = 789

		
		--test-- "loc-simple object 1"
			so1-a: 0
			so1-o: make object! [so1-a: 1]
			--assert so1-a = 0
			--assert so1-o/so1-a = 1
			
		--test-- "loc-simple object 2"
			so2-s: "0"
			so2-o: make object! [so2-s: "1"]
			--assert so2-s = "0"
			--assert so2-o/so2-s = "1"
			
		--test-- "loc-simple object 3"
			so3-s: "0"
			so3-i: 0
			so3-l: true
			so3-c: #"a"
			so3-b: [a b c]
			so3-bs: charset #"^(00)"
			so3-o: make object! [
				so3-s: "1"
				so3-i: 1
				so3-l: false
				so3-c: #"b"
				so3-b: [a b d]
				so3-f: func [][1]
				so3-bs: charset #"^(01)"
			]
			--assert so3-s = "0"
			--assert so3-o/so3-s = "1"
			--assert so3-i = 0
			--assert so3-o/so3-i = 1
			--assert so3-l = true
			--assert so3-o/so3-l = false
			--assert so3-c = #"a"
			--assert so3-o/so3-c = #"b"
			--assert so3-b = [a b c]
			--assert so3-o/so3-b = [a b d]
			--assert so3-f = 0
			--assert so3-o/so3-f = 1
			--assert "make bitset! #{80}" = mold so3-bs
			--assert "make bitset! #{40}" = mold so3-o/so3-bs
			

		--test-- "loc-no1"
			no1-o: make object! [o: make object! [i: 1] ]
			--assert no1-o/o/i = 1
			
		--test-- "loc-no2"
			no2-o1: make object! [
				o2: make object! [
					i: 1
				]
			]
			--assert no2-o1/o2/i = 1
			
		--test-- "loc-no3"
			no3-o1: make object! [
				o2: make object! [
				o3: make object! [
				o4: make object! [
					i: 1
				]]]
			]
			--assert no3-o1/o2/o3/o4/i = 1

		--test-- "loc-no4"
			no4-o1: make object! [
				o2: make object! [
				o3: make object! [
				o4: make object! [
				o5: make object! [
				o6: make object! [
				o7: make object! [
					i: 1
				]]]]]]
			]
			--assert no4-o1/o2/o3/o4/o5/o6/o7/i = 1
		
		--test-- "loc-no5"
			no5-o1: make object! [
				o2: make object! [
				o3: make object! [
				o4: make object! [
				o5: make object! [
				o6: make object! [
				o7: make object! [
				o8: make object! [
				o9: make object! [
				o10: make object! [
				o11: make object! [
				o12: make object! [
				o13: make object! [
				;o14: make object! [
				;o15: make object! [
					i: 1
				]]]]]]]]]]]]
			]
			--assert no5-o1/o2/o3/o4/o5/o6/o7/o8/o9/o10/o11/o12/o13/i = 1
			
		--test-- "loc-no6 issue #928"
			no6-o: make object! [
				a: 1
				o: make object! [
					b: 2
					f: does [a]
					]
				]
			--assert 1 = no6-o/o/f
		

		--test-- "loc-op1"
			op1-o1: make object! [i: 1]
			op1-o2: make op1-o1 []
			--assert op1-o2/i = 1
			
		--test-- "loc-op2"
			op2-o1: make object! [i: 1]
			op2-o2: make op2-o1 [i: 2]
			--assert op2-o2/i = 2
			--assert op2-o1/i = 1

		--test-- "loc-op3"
			op3-o1: make object! [i: 1]
			op3-o2: make op3-o1 [i: 2 j: 3]
			--assert op3-o2/i = 2
			--assert op3-o2/j = 3
			

		--test-- "loc-oip1"
			oip1-i: 1
			oip1-o: make object! [
				i: oip1-i
			]
			--assert 1 = oip1-o/i
			
		--test-- "loc-oip2"
			oip2-i: 1
			oip2-o: make object! [
				i: either oip2-i = 1 [2] [3]
			]
			--assert 2 = oip2-o/i
		
		--test-- "loc-oip3"
			oip3-i: 1
			oip3-o: make object! [
				i: 0
				set 'oip3-i 2
			]
			--assert 2 = oip3-i
			
		--test-- "loc-oip4"
			set 'oip4-i none
			oip4-o: make object! [
				i: 0
				set 'oip4-i 3
			]
			--assert 3 = oip4-i


		--test-- "loc-inherit-1"
			proto: context [
				a: 123
				get-a: does [a]
			]
			new: make proto [a: 99]
			--assert new/a = 99
			--assert new/get-a = 99
			--assert proto/a = 123
			--assert proto/get-a = 123

		--test-- "loc-inherit-2"
			new/a: 456
			--assert new/get-a = 456
			proto/a: 759
			--assert proto/a = 759
			--assert new/get-a = 456

		--test-- "loc-inherit-3"
			newnew: make new [
				reset: does [a: none]
			]
			--assert newnew/a = 456
			newnew/reset
			--assert none? newnew/a
			--assert new/a = 456
			--assert proto/a = 759

		--test-- "loc-inherit-4"
			base: context [
				v: 0
				foo: does [v]
			]

			i: 0
			list: []
			loop 2 [
				bb: make base [v: i]
				--assert bb/foo = i
				append list bb
				i: i + 1
			]
			--assert object? list/1
			--assert list/1/v = 0
			--assert list/2/v = 1

#if config/dev-mode? = no [							;-- libRed does not support multiple-inheritance
		--test-- "loc-inherit-5"
			base5: context [
				b: 123
				get-b: does [b]
				a: object [
					b: 456
					double: does [b * 2]
					set-b: func [/with v] [b: either with [v]['hello]]
				]
			]
			proto5: context [
				b: 999
				value: 71
				foo: does [b + value]
			]
			new: make base5 proto5
			--assert object? new
			--assert new/b = 999
			--assert new/value = 71
			--assert new/a/b = 456
			--assert base5/b = 123

		--test-- "loc-inherit-6"
			--assert new/get-b = 999
			--assert new/a/double = 912
			new/a/set-b/with 10
			--assert new/a/b = 10
			--assert new/b = 999
			--assert base5/b = 123
			--assert new/a/double = 20
			--assert base5/a/double = 20

		--test-- "loc-inherit-7"
			--assert same? new/a base5/a

		--test-- "loc-inherit-8"
			--assert new/foo = 1070
]
		--test-- "loc-inherit-9"
			base9: context [
				v: 123456
				show: does [v]
			]
			i: 100
			list: []
			loop 3 [
				new9: make base9 [v: i]
				--assert new9/v = i
				--assert new9/show = i
				append list new9
				i: i + 1
			]
			--assert base9/v = 123456
			--assert list/1/v = 100
			--assert list/2/v = 101
			--assert list/3/v = 102


		--test-- "loc-ext-1"
			p1: object [
			    a: 1
			    b: 2
			]

			p1/a: context [
				t: 99
				z: 128
				q: object [zz: 345 show: does [zz]]
			]
			--assert object? p1/a
			--assert p1/a/z = 128
			--assert p1/a/q/show = 345

		--test-- "loc-ext-2"
			p1/a/t: does [123]
			--assert p1/a/t = 123

		--test-- "loc-dyn-1"
			d: context [
				value: 998
			    f: does [value]
			]
			;h: :d/f
			;--assert h = 998
			;d/value: 123
			;--assert 123 = do [h]

		--test-- "loc-dyn-2"

			o: make f-make-obj-1 [a: 3]
			--assert 46 = do [o/j 45]			;@@ temporary workaround until dyn-stack branch
			--assert 101 = do [o/j 100]			;@@ temporary workaround until dyn-stack branch

		--test-- "loc-dyn-3"
			--assert 52 = do [o/j o/j 50]		;@@ temporary workaround until dyn-stack branch

		--test-- "loc-dyn-4"
			--assert 33 = do [o/g/with 20]		;@@ temporary workaround until dyn-stack branch
			--assert 59 = do [o/g/with o/j 45]	;@@ temporary workaround until dyn-stack branch

		--test-- "loc-dyn-5"
			z: none
			--assert 12 = do [o/j z: 5 + 6]		;@@ temporary workaround until dyn-stack branch
			--assert  z = 11

		--test-- "loc-dyn-6"
			--assert [17] = reduce [do [o/j o/j z: 5 + 10]] ;@@ temporary workaround until dyn-stack branch
			--assert z = 15

		--test-- "loc-dyn-7"
			repeat c 1 [
				if yes [
					--assert 52 = do [o/j o/j 50]
					--assert 59 = do [o/g/with o/j 45] ;@@ temporary workaround until dyn-stack branch
					--assert [22] = reduce [do [o/j o/j z: 5 + 15]] ;@@ temporary workaround until dyn-stack branch
					--assert z = 20
				]
			]

		--test-- "loc-dyn-8"
			o2: context [zz: none]				;-- test renaming a statically compiled object
			
			o2: f-make-obj-2
			--assert 1 = do [o2/g]				;@@ temporary workaround until dyn-stack branch

		--test-- "loc-dyn-9"
			o2: f-make-obj-2/alt
			--assert 123 = o2/g

		--test-- "loc-dyn-10"

			o: context [a: [123 789]]
			--assert if o/a [true]
			--assert if block? o/a [true]
			--assert if 123 = first o/a [true]

		--test-- "loc-dyn-11"
			--assert either o/a [true][false]
			--assert either block? o/a [true][false]
			--assert either 789 = second o/a [true][false]

		--test-- "loc-dyn-12"
			--assert block? all [o/a]
			--assert not 	all [false o/a]
			--assert not 	all [o/a false]
			--assert 456 = 	all [o/a 456]

		--test-- "loc-dyn-13"
			--assert block? any [o/a 0]
			--assert block? any [false o/a]
			--assert block? any [o/a false]
			--assert block? any [o/a 456]
			--assert 654 =  any [654 o/a]

		--test-- "loc-dyn-14"
			foreach p o/a [--assert any [p = 123 p = 789]]

		--test-- "loc-dyn-15"
			loop length? o/a [--assert any [p = 123 p = 789]]

		--test-- "loc-dyn-16"
			repeat c length? o/a [--assert any [c = 1 c = 2]]

		--test-- "loc-dyn-17"
			repeat c 125 - first o/a [--assert any [c = 1 c = 2]]

		--test-- "loc-dyn-18"
			switch/default first o/a [
				123 [
					--assert true
					switch/default second o/a [
						789 [--assert true]
					][--assert false]
				]
				789 [--assert false]
			][--assert false]

		--test-- "loc-dyn-19"
			 --assert 0 < first o/a

		--test-- "loc-dyn-20"
			case [
				first o/a  	[--assert true]
				'else 		[--assert false]
			]

		--test-- "loc-dyn-21"
			case [
				0 < first o/a [--assert true]
				'else	  	  [--assert false]
			]

		--test-- "loc-dyn-22"
			case [
				0 = first o/a 	  [--assert false]
				789 = second o/a  [--assert true]
			]

		--test-- "loc-dyn-23"
			c: context [
				x: 1
				f: func [o [object!]][x: do [o/a]]	;@@ temporary workaround until dyn-stack branch
			]

			c/f object [a: 123]
			--assert c/x = 123

			c/f object [a: does [99]]
			--assert c/x = 99

		--test-- "loc-dyn-24"					;; issue #965
			o: [a "hello" b " world"]
			--assert "hello" = o/a
			--assert "hello world" = append o/a o/b
			--assert "hello world123" = append o/a 123 o/b

		--test-- "loc-dyn-25"
			o: context [
				a: func [v][v * 2]
				b: 123
			]
			--assert 143 = add o/a 10 o/b
			--assert 256 = add o/a o/b 10

		--test-- "loc-copy-1"
			co1: make object! [a: 1]
			co2: copy co1
			co1/a: 2
			--assert 2 = co1/a
			--assert 1 = co2/a
		
		--test-- "loc-copy-2"
			co1: make object! [
				a: 1
				f: func[][a]
			]
			co2: copy co1
			co1/a: 2
			--assert 2 = co1/f
			--assert 1 = do [co2/f]		;@@ temporary workaround until dyn-stack branch
			
		--test-- "loc-copy-3"
			co1: make object! [
				a: 1
				b: 2
				blk: [1 2 3 4]
			]
			co2: copy co1
			co1/blk/1: 5
			--assert 5 = co1/blk/1 
			--assert 5 = do [co2/blk/1]	;@@ temporary workaround until dyn-stack branch
			
		--test-- "loc-copy-4"
			co1: make object! [
				a: 1
				b: 2
				blk: [1 2 3 4]
			]
			co2: copy/deep co1
			co1/blk/1: 5
			--assert 5 = co1/blk/1 
			--assert 1 = do [co2/blk/1]
			
		--test-- "loc-copy-5"
			co1: make object! [
				a: 1
				s: "Silly old string"
				f: func [][
					[s a]
				]
			]
			co2: copy co1
			co1/a: 5
			co1/s/2: #"h"
			co1/s/3: #"i"
			co1/s/4: #"n"
			--assert "Shiny old string" = co1/s
			--assert "Shiny old string" = co2/s
			
		--test-- "loc-copy-6"
			co1: make object! [
				a: 1
				s: "Silly old string"
			]
			co2: copy co1
			co1/a: 5
			co1/s/2: #"h"
			co1/s/3: #"i"
			co1/s/4: #"n"
			replace co1/s "old" "new"
			--assert "Shiny new string" = co1/s
			--assert "Shiny new string" = co2/s
			
		--test-- "loc-copy-7"
			co5: make object! [
				a: 1
				s: "Silly old string"
			]
			co6: copy/deep co5
			co5/a: 5
			co5/s/2: #"h"
			co5/s/3: #"i"
			co5/s/4: #"n"
			replace at co5/s 7 "old" "new"
			--assert "Shiny new string" = co5/s
			--assert "Silly old string" = co6/s
			
		--test-- "loc-copy-8"
			co1: make object! [
				s: "Silly old string"
				f: func[][s]
			]
			co2: copy co1
			co1/s/2: #"h"
			co1/s/3: #"i"
			co1/s/4: #"n"
			replace co1/s "old" "new"
			--assert "Shiny new string" = co1/f
			--assert "Shiny new string" = do [co2/f]	;@@ temporary workaround until dyn-stack branch
			
		--test-- "loc-copy-9"
			co1: make object! [
				s: "Silly old string"
				f: func[][s]
			]
			co2: copy/deep co1
			co1/s/2: #"h"
			co1/s/3: #"i"
			co1/s/4: #"n"
			replace co1/s "old" "new"
			--assert "Shiny new string" = co1/f
			--assert "Silly old string" = do [co2/f] ;@@ temporary workaround until dyn-stack branch
		
		--test-- "loc-copy-10"
			co1: make object! [
				a: 1
				f: func[][a]
			]
			co2: copy/deep co1
			co1/a: 2
			--assert 2 = co1/f
			--assert 1 = do [co2/f]				;@@ temporary workaround until dyn-stack branch
			
		--test-- "loc-copy-11"
			co1: make object! [
				a: 1
				oo: make object! [
					f: func[][a]
				]
			]
			co2: copy/deep co1
			co1/a: 2
			--assert 2 = co1/oo/f
			--assert 2 = do [co2/oo/f]			;@@ temporary workaround until dyn-stack branch
			
		--test-- "loc-copy-12"
			co1: make object! [
				a: 1
				oo: make object! [
					f: func[][a]
				]
			]
			co2: copy/deep co1
			co1/a: 2
			--assert 2 = co1/oo/f
			--assert 2 = do [co2/oo/f]			;@@ temporary workaround until dyn-stack branch

		--test-- "loc-in1"
			ino1: make object! [
				i: 1
				c: #"a"
				f: 1.0
				b: [1 2 3 4]
				s: "abcdef"
				o: make object! [
				]
			]
			--assert 'i = in ino1 'i
			--assert 'c = in ino1 'c
			--assert 'b = in ino1 'b
			--assert 'f = in ino1 'f
			--assert 's = in ino1 's
			--assert 'o = in ino1 'o
			

		--test-- "loc-in2"
			ino1: make object! [
				i: 1
				c: #"a"
				f: 1.0
				b: [1 2 3 4]
				s: "abcdef"
				o: make object! [
					c: #"b"
					i: 2
					f: 2.0
					b: [5 6 7 8]
					s: "ghijkl"
					o: make object! [
					]
				]
			]
			--assert 'i = in ino1 'i
			--assert 'c = in ino1 'c
			--assert 'b = in ino1 'b
			--assert 'f = in ino1 'f
			--assert 's = in ino1 's
			--assert 'o = in ino1 'o
			--assert 'i = in ino1/o 'i
			--assert 'c = in ino1/o 'c
			--assert 'b = in ino1/o 'b
			--assert 'f = in ino1/o 'f
			--assert 's = in ino1/o 's
			--assert 'o = in ino1/o 'o


		--test-- "loc-in3"
			ino1: make object! [
				i: 1
				c: #"a"
				f: 1.0
				b: [1 2 3 4]
				s: "abcdef"
				o: make object! [
					c: #"b"
					i: 2
					f: 2.0
					b: [5 6 7 8]
					s: "ghijkl"
					o: make object! [
						c: #"c"
						i: 3
						f: 3.0
						b: [9 10 11 12]
						s: "mnopqr"
						o: make object! [
						]
					]
				]
			]
			--assert 'i = in ino1 'i
			--assert 'c = in ino1 'c
			--assert 'b = in ino1 'b
			--assert 'f = in ino1 'f
			--assert 's = in ino1 's
			--assert 'o = in ino1 'o
			--assert 'i = in ino1/o 'i
			--assert 'c = in ino1/o 'c
			--assert 'b = in ino1/o 'b
			--assert 'f = in ino1/o 'f
			--assert 's = in ino1/o 's
			--assert 'o = in ino1/o 'o
			--assert 'i = in ino1/o/o 'i
			--assert 'c = in ino1/o/o 'c
			--assert 'b = in ino1/o/o 'b
			--assert 'f = in ino1/o/o 'f
			--assert 's = in ino1/o/o 's
			--assert 'o = in ino1/o/o 'o

		--test-- "loc-in4"
			ino1: make object! [
				i: 1
				c: #"a"
				f: 1.0
				b: [1 2 3 4]
				s: "abcdef"
				o: make object! [
					c: #"b"
					i: 2
					f: 2.0
					b: [5 6 7 8]
					s: "ghijkl"
					o: make object! [
						c: #"c"
						i: 3
						f: 3.0
						b: [9 10 11 12]
						s: "mnopqr"
						o: make object! [
							c: #"d"
							f: 4.0
							i: 4
							b: [13 14 15 16]
							s: "stuvwx"
						]
					]
				]
			]
			--assert 'i = in ino1 'i
			--assert 'c = in ino1 'c
			--assert 'b = in ino1 'b
			--assert 'f = in ino1 'f
			--assert 's = in ino1 's
			--assert 'o = in ino1 'o
			--assert 'i = in ino1/o 'i
			--assert 'c = in ino1/o 'c
			--assert 'b = in ino1/o 'b
			--assert 'f = in ino1/o 'f
			--assert 's = in ino1/o 's
			--assert 'o = in ino1/o 'o
			--assert 'i = in ino1/o/o 'i
			--assert 'c = in ino1/o/o 'c
			--assert 'b = in ino1/o/o 'b
			--assert 'f = in ino1/o/o 'f
			--assert 's = in ino1/o/o 's
			--assert 'o = in ino1/o/o 'o
			--assert 'i = in ino1/o/o/o 'i
			--assert 'c = in ino1/o/o/o 'c
			--assert 'b = in ino1/o/o/o 'b
			--assert 'f = in ino1/o/o/o 'f
			--assert 's = in ino1/o/o/o 's
		
		--test-- "loc-in5"
			in5-f: func[] [make object! [a: 1]]
			if system/state/interpreted? [
				--assert 1 = get in in5-f 'a	
			]
	]

	local-obj-fun

===end-group===

===start-group=== "objects within functions"

	--test-- "owf1 #946"
		owf1-o: make object! [
			a: 1
			f: func [/local o][
				o: make object! [
					a: 2
				]
				o/a
			]
		]
		--assert 2 = owf1-o/f
		
	--test-- "owf2 #956"
		owf2-o: make object! [
			a: 1
			f: func [/local o][
				o: make object! [
					a: 2
				]
				either o/a [o/a] [99]
			]
		]
		--assert 2 = owf2-o/f
		
	--test-- "owf3 - #957"
		owf3-f: func [
			o [object!]
		][
			switch o/a [
				0 [0]
				1 [1]
				2 [2]
			]		
		
		]
		owf3-o: make object! [
			a: 1
		]
		--assert 1 = owf3-f owf3-o
		
	--test-- "owf4 - #947"
		owf4-f: func [
			o [object!]
		][
			either o/a [o/a] [99]		
		]
		owf4-o: make object! [
			a: 1
		]
		--assert 1 = owf4-f owf4-o
		
	--test-- "owf5"
		owf5-o: make object! [
			a: 1
			f: func [][
				o: make object! [        	;-- in global context
					a: 2
				]
				o/a
			]
		]
		--assert 2 = owf5-o/f
		
	--test-- "owf6"
		owf6-o: make object! [
			a: 1
			f: func [][
				o: make object! [			;-- in global context
					a: 2
				]
				either o/a [o/a] [99]
			]
		]
		--assert 2 = owf6-o/f

	--test-- "owf7 - #959"
		owf7-o: make object! [
			owf7-x: none
			f: func [
				o [object!]
			][
				owf7-x: o/a
			]
		]
		owf7-oo: make object! [a: 1]
		--assert 1 = owf7-o/f owf7-oo
		
	--test-- "owf8 - #960"
		owf8-o: make object! [
			owf8-oo: make object! [a: 1]
		]
		owf8-f:  does [owf8-o/owf8-oo]
		;owf8-f2: func [o [object!]] [o/a]	;-- can be replaced once 'in is written
		--assert 1 = get in owf8-f 'a

	--test-- "owf9 - #962"
		owf9-f: func [
			o [object!]
			/local
				v	
		][
			v: none
			case [
				all [
					o/a = o/a
					o/a = o/a
				][
					o/a
				]
			]
		]
		owf9-o: make object! [a: 1]
		--assert 1 = owf9-f owf9-o

	--test-- "owf10 - #962"
		owf10-f: func [
			o [object!]
		][
			v: none							;-- in global context	
			case [
				all [
					o/a = o/a
					o/a = o/a
				][
					o/a
				]
			]
		]
		owf10-o: make object! [a: 1]
		--assert 1 = owf10-f owf10-o
											
	--test-- "owf11 - #962"
		owf11-f: func [
			o [object!]
			/local
				v	
		][
			v: none
			case [
				all [
					equal? o/a o/a
					equal? o/a o/a
				][
					o/a
				]
			]
		]
		owf11-o: make object! [a: 1]
		--assert 1 = owf11-f owf11-o
	
	--test-- "owf12 - #962"
		owf12-f: func [
			o [object!]
		][
			v: none							;-- in global context	
			case [
				all [
					equal? o/a o/a
					equal? o/a o/a
				][
					o/a
				]
			]
		]
		owf12-o: make object! [a: 1]
		--assert 1 = owf12-f owf12-o
		
	--test-- "owf13"
		owf13-f: func [
			o [object!]
			/local v
		][
			v: none
			either o/a = o/b [
 			    1234
			][
			    0
			]
		]
		owf13-o: make object! [a: 1 b: 1]
	    --assert 1234 = owf13-f owf13-o
		
===end-group===

===start-group=== "case sensitivity"

	--test-- "ocs1"
		ocs1-o: make object! [A: 1]
		--assert ocs1-o/A = 1
		--assert ocs1-o/A == 1
		--assert ocs1-o/a = 1
		--assert ocs1-o/a == 1
		
	--test-- "ocs2"
		ocs2-o: make object! [a: 1 A: 2]
		--assert ocs2-o/a = 2
	
	--test-- "ocs3"
		ocs3-o: make object! [a: 1 if true [A: 2]]
		--assert ocs3-o/a = 2
		
	--test-- "ocs3"
		ocs3-o: make object! [a: 1 if false [A: 2]]
		--assert ocs3-o/a = 1
		
	--test-- "ocs4"
		ocs4-o: make object! [a: 1]
		--assert 'A = in ocs4-o 'A
		--assert 'a = in ocs4-o 'A
		--assert 'A == in ocs4-o 'A

===end-group===

===start-group=== "reflection"

	--test-- "or1"
		or1: make object! [a: 1 b: 2.1 c: "three"]
		--assert [a b c] = words-of or1
		--assert [1 2.1 "three"] = values-of or1
		--assert [a: 1 b: 2.1 c: "three"] = body-of or1

===end-group===

===start-group=== "changed fields"
	
	reset: func [foo [object!]][modify foo 'changed none]
	ebbs?: func [foo [object!]][reflect foo 'changed]
	
	foo: reset object [x: y: 0]						;@@ RESET is required to trick the compiler

	--test-- "changed-1"		
		--assert [] = ebbs? foo
		foo/x: 1
		--assert [x] = ebbs? foo
		
	--test-- "changed-2"
		put foo 'y 2
		--assert [x y] = ebbs? foo
		--assert [] = ebbs? reset foo
	
	--test-- "changed-3"
		do bind [x: y: 0] foo
		--assert [x y] = ebbs? foo
		
	--test-- "changed-4"
		set in reset foo 'y 1
		--assert [y] = ebbs? foo
		
	--test-- "changed-5"
		set 'foo/x 2
		--assert [x y] = ebbs? foo
		--assert [] = ebbs? reset foo
	
	--test-- "changed-6"
		set foo [bar]
		--assert [x y] = ebbs? foo					;-- Y was set to NONE
	
	--test-- "changed-7"
		set/some reset foo [bar]
		--assert [x] = ebbs? foo					;-- Y was ignored
	
	--test-- "changed-8"
		set reset foo object []
		--assert [] = ebbs? foo
	
	--test-- "changed-9"
		set reset foo object [y: 2]
		--assert [y] = ebbs? foo
	
	--test-- "changed-10"
		set reset foo object [x: 1 y: 2]
		--assert [x y] = ebbs? foo
	
===end-group===

===start-group=== "set"

	--test-- "os1"
		os1: make object! [a: 1 b: 2 c: 3]
		set os1 none
		--assert equal? reduce [none none none] values-of os1
		
	--test-- "os2"
		os2: make object! [a: 1 b: 2 c: 3]
		set os2 [1.2 2.3 3.4]
		--assert equal? [1.2 2.3 3.4] values-of os2
		
	--test-- "os3"
		os3-a: make object! [x: 1 y: 2 z: 3]
		os3-b: make object! [x: 11 y: 22 z: 33]
		set os3-a os3-b
		--assert equal? words-of os3-a [x y z]
		--assert equal? values-of os3-a [11 22 33]
		
	--test-- "os4"
		os4-a: make object! [x: 1 y: 2 z: "string 1"]
		os4-b: make object! [x: 11 y: 22 z: "string 2"]
		set os4-a os4-b
		--assert equal? words-of os4-a [x y z]
		--assert equal? values-of os4-a [11 22 "string 2"]
		append os4-a/z "2"
		--assert equal? os4-b/z "string 22"
		
	--test-- "os5"
		os5-a: make object! [x: 1 y: 2 z: 3]
		set/only os5-a [1 2 3]
		--assert equal? values-of os5-a [[1 2 3] [1 2 3] [1 2 3]]
		
	--test-- "os6"
		os6-a: make object! [x: 1 y: 2 z: 3]
		os6-b: make object! [x: 11 y: 22 z: 33]
		set/only os6-a os6-b
		--assert equal? words-of os6-a [x y z]
		--assert equal? os6-a/x make os6-b []
		--assert equal? os6-a/y make os6-b []
		--assert equal? os6-a/z make os6-b []
		
	--test-- "os7"
		os7-a: make object! [z: 1 y: 2 x: 3]
		set os7-a [11 22 33]
		--assert equal? os7-a/z 11
		--assert equal? os7-a/y 22
		--assert equal? os7-a/x 33
	 	
				
===end-group===

===start-group=== "get"

	--test-- "og1"
		og1: make object! [a: 1 b: 2 c: "x"]
		--assert equal? [1 2 "x"] get og1
		--assert equal? [1 2 "x"] get :og1
		--assert equal? [1 2 "x"] get/any :og1
		--assert equal? [1 2 "x"] get/case :og1
		--assert same? og1/c last get og1
		--assert equal? 2 get 'og1/b
		--assert empty? get object []

===end-group===

===start-group=== "select"

	--test-- "ofs"
		ofs1: make object! [a: 1]
		;;--assert find ofs1 'a
		--assert 1 = select ofs1 'a
		
	--test-- "ofs2"
		ofs2: make object! [a: none]
		;;--assert find ofs2 'a
		--assert none = select ofs2 'a
		
	--test-- "ofs3"
		ofs3: make object! [a: 1]
		;;--assert not find ofs3 'b
		--assert not select ofs3 'b

===end-group===

===start-group=== "on change"

	--test-- "ooc1"
		ooc1: make object! [
			on-change*: func [word old new] [
				if word = 'a [ b: 3 * a]
			]
			a: 1
			b: a * 2
		]
		ooc1/a: 3
		--assert ooc1/b = 9
		
===end-group===

===start-group=== "on deep change"

	--test-- "oodc1"
		oodc1: make object! [
			on-deep-change*: func [
				owner word target action new index part
			][
				a: length? b
			]
			a: 0
			b: [1 2 3 4 5]
		]
		append oodc1/b 6
		--assert oodc1/a = 6
		append oodc1/b [7 8 9]
		--assert oodc1/a = 9
		append/only oodc1/b [10 11 12]
		--assert oodc1/a = 10
		append oodc1/b/10 13
		--assert oodc1/a = 10
	
	--test-- "oodc2"
		oodc2: make object! [
			on-deep-change*: func [
				owner word target action new index part
			][
				if action = 'appended [
					if equal? mold owner mold make object! [a: 0 b: [1 2 3 4 5 6]] [a: a + 1]
					if equal? word 'b [a: a + 10]
					if equal? target [1 2 3 4 5 6] [a: a + 100]
					if equal? action 'appended [a: a + 1000]
					if equal? new 6 [a: a + 10000]
					if equal? index 5 [a: a + 100000]
					if equal? part 1 [a: a + 1000000]
				]
			]
			a: 0
			b: [1 2 3 4 5]
		]
		append oodc2/b 6
		--assert oodc2/a = 1111111
		
===end-group===

===start-group=== "construct"

	--test-- "oc1"
		oc1: construct [b: 2 c: print]
		--assert (body-of oc1) == [b: 2 c: 'print]

	--test-- "oc2"
		oc2: construct/with [d: append] oc1
		--assert (body-of oc2) == [b: 2 c: 'print d: 'append]

	--test-- "oc3"
		spec: [z: 3 y: insert]
		oc3: construct/with spec oc1
		--assert (body-of oc3) == [b: 2 c: 'print z: 3 y: 'insert]

	--test-- "oc4"
		blk: [b: 2 c: print]
		oc4: construct blk
		--assert (body-of oc4) == [b: 2 c: 'print]

	--test-- "oc5"
		blk: [b: 2 c: print]
		oc5: object [a: 1]
		oc51: construct/with blk oc5
		--assert (body-of oc51) == [a: 1 b: 2 c: 'print]

	--test-- "oc6"
		blk: [b: 6 c: print]
		oc6: construct/with blk object [a: 5]
		--assert (body-of oc6) == [a: 5 b: 6 c: 'print]

	--test-- "oc7"
		oc7: construct [a: true]
		--assert logic? oc7/a
		oc71: construct/only [a: true]
		--assert word? oc71/a
		oc72: construct/only/with [b: true] oc7
		--assert logic? oc72/a
		--assert word?  oc72/b

===end-group===

===start-group=== "regression tests"

	--test-- "issue #2920"
		a: context [e: 1 d: [e]]
		b: make a [e: 2]
		--assert 1 = do a/d
		--assert 2 = do b/d
		
	--test-- "issue #3516"
		iss-3516-c: context [ f: func [a] [] ]
		;; COMMENTED OUT
		;;--assert not error? try [ iss-3516-t: iss-3516-c/f [] ]


	--test-- "issue #3406"
		do [						;-- cannot run this test using libRedRT
			b3406: context [x: 2  f: does [x]]
			c3406: context [f: does [x]  x: 3]
			d3406: construct/with [x: 4] b3406
			e3406: construct/with [x: 5] c3406

			--assert b3406/f = 2
			--assert c3406/f = 3
			--assert d3406/f = 4
			--assert e3406/f = 5

			;-- alternative to 3406 merging objects using MAKE
			
			g3406: context [f: does [x]  x: 3]
			h3406: make g3406 object [x: 5]
			--assert h3406/f = 5
		]

	--test-- "issue #4765"
		a4765: make object! [ x: 1 show: does [x] ]
		b4765: make object! [ x: 2 y: 3 show: does [reduce [x y]] ]
		c4765: make a4765 b4765
		--assert a4765/show == 1
		--assert b4765/show == [2 3]

		a4765x: make object! [ x: 1 show: does [x] ]
		b4765x: make object! [ x: 2 show: does [reduce [x y]] y: 3]
		c4765x: make a4765x b4765x
		--assert a4765x/show == 1
		--assert b4765x/show == [2 3]

	--test-- "#3804"
		checks: 0
		o3804: object [
			i: 1
			on-change*: func [w o n] [checks: checks + 1]
		]
		o3804/i: o3804/i + 1
		set in o3804 'i o3804/i + 1
		do bind [i: i + 1] o3804
		--assert checks = 3
	
	--test-- "#3805"
		do [
			checks: 0
			d3805: make reactor! [
				set-quiet 'on-change* func
					spec-of :reactor!/on-change*
					compose [
						checks: checks + 1
						(bind copy/deep body-of :reactor!/on-change* self)
					]
				a: "123"
			]
			d3805/a: "456"
			append d3805/a "4"
			--assert checks = 2
			--assert d3805/a = "4564"
		]

	--test-- "#4500"
		do [
			r4500: reactor [
				x: 1
				on-change*: function spec-of :on-change* bind/copy body-of :on-change* self
			]
			src4500: reactor [a: b: none]
			tgt: [0 "tgt block"]
			react [tgt/1: src4500/a]
			r4500/x: tgt
			src4500/a: 100
			--assert tgt/1 = 100
		]

	--test-- "#4552"
		do [
			--assert (make object! []) = context? object [return quote self]
			--assert same? (context? 'do) context? object [return 'self]
		]

	--test-- "#4787"
		do [
			events: 0
			o: make deep-reactor! [
				on-deep-change*: func [o w t a n i p /local x] [
					y: context? 'o
					--assert function? :y
					--assert false == :local
					--assert none? :x
					local: p: x: :y
					p: x: :y
					--assert function? :y
					--assert function? :p
					--assert function? :x
					--assert function? :local
					events: events + 1
				]
				x: []
				append x 1
			]
			--assert events = 2
			--assert o/x = [1]

			events: 0
			o1: object [on-change*: func [word old new] []]
			o2: make o1 [
				on-change*: func [word old new /local x] [
					--assert none? :x
					--assert false == :local
					events: events + 1
				]
				v: 0
			]
			--assert events = 2
			o2/v: 1
			--assert events = 3
		]

	--test-- "#5135"
		do [
			r2-5135: none
			r1-5135: reactor [x: 0 y: is [x] set 'r2-5135 self]
			--assert same? r1-5135 r2-5135
			r1-5135/x: 1
			--assert all [r1-5135/x = 1 r1-5135/y = 1]
			r2-5135/x: 2
			--assert all [r2-5135/x = 2 r2-5135/y = 2]
		]

	--test-- "#5190"
		do [
			--assert error? try [object [self/self/self: 1 probe self]]
		]

===end-group===

~~~end-file~~~
