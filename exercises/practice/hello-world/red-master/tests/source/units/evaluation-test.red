Red [
	Title:   "Red evaluation test script"
	Author:  "Nenad Rakocevic"
	File: 	 %evaluation-test.red
	Tabs:	 4
	Rights:  "Copyright (C) 2011-2018 Red Foundation. All rights reserved."
	License: "BSD-3 - https://github.com/red/red/blob/origin/BSD-3-License.txt"
]

#include  %../../../quick-test/quick-test.red

~~~start-file~~~ "evaluation"

===start-group=== "do"

	--test-- "do-1"
		--assert 123 = do [123]
		
	--test-- "do-2"
		--assert none = do [none]
		
	--test-- "do-3"
		--assert false = do [false]
		
	--test-- "do-4"
		--assert 'z = do ['z]
		
	--test-- "do-5"
		a: 123
		--assert 123 = do [a]
		
	--test-- "do-6"
		--assert 3 = do [1 + 2]
		
	--test-- "do-7"
		--assert 7 = do [1 + 2 3 + 4]
		
	--test-- "do-8"
		--assert 9 = do [1 + length? mold append [1] #"t"]
		
	--test-- "do-9"
		--assert word! = do [type? first [a]]

	--test-- "do/next-1"
		code: [3 4 + 5 length? mold 8 + 9 append copy "hel" form 'lo]
		--assert 3 		 = do/next code 'code
		--assert 9 		 = do/next code 'code
		--assert 2 		 = do/next code 'code
		--assert "hello" = do/next code 'code
		--assert unset? do/next code 'code
		--assert unset? do/next code 'code
		--assert tail? code
		--assert (head code) = [3 4 + 5 length? mold 8 + 9 append copy "hel" form 'lo]
		
===end-group===

===start-group=== "do function"
	
	--test-- "do-func-1"
		df1-f: func[][1]
		--assert 1 = do [df1-f] 
		
	--test-- "do-func-2"
		df2-f: func[i][2 * i]
		--assert 4 = do [df2-f 2]
		
	--test-- "do-func-3"
		df3-f: func[][3]
		--assert 3 = do df3-f
		
	--test-- "do-func-4"
		df4-i: 4
		df4-f: [func[i][df4-i * i] 4]
		--assert 16 = do reduce df4-f
		
	--test-- "do-func-5"
		df5-f: func[i][5 * i]
		--assert 25 = do [df5-f 5]
		
	--test-- "do-func-6"
		df6-i: 6
		df6-f: func[i][df6-i * i]
		--assert 36 = do [df6-f 6]
		
===end-group=== 

===start-group=== "do object"

	--test-- "do-object-1"
		do1-blk: load {
			o: make object! [
				oo: make object! [
					ooo: make object! [
						a: 1
					]
				]
			]
		}
		do do1-blk
		--assert 1 == o/oo/ooo/a

===end-group===

===start-group=== "do path"

	--test-- "do-path-1"
		t: 0
		f: func [/x] [t: 1 2]
		--assert 2 == do 'f/x
		--assert 1 == t

	--test-- "do-path-2"
		t: 0
		f: func [/x] [t: 1 2]
		--assert 2 == do as path! [f x]
		--assert 1 == t

	--test-- "do-path-3"
		t: 0
		f: func [/x] [t: 1 2]
		g: does ['f/x]
		--assert 2 == do g
		--assert 1 == t


	--test-- "do-path-4"								;-- path to func inside object
		t: 0
		o: make object! [
			f: func [/x] [t: 1 2]
		]
		g: does ['o/f/x]
		--assert 2 == do g
		--assert 1 == t

	--test-- "do-path-5"								;-- forbid variadic use: should not take args
		t: 0
		f: func [/x y] [t: 1 2]
		g: does ['f/x]
		--assert error? try [do g 'arg]

	--test-- "do-path-6"								;-- forbid variadic use: should not take args
		t: 0
		o: make object! [
			f: func [/x y] [t: 1 2]
		]
		g: does ['o/f/x]
		--assert error? try [do g 'arg]

===end-group===

===start-group=== "do trace"

	logs: make block! 100

	logger: function [
		event  [word!]
		code   [any-block! none!]
		offset [integer!]
		value  [any-type!]
		ref	   [any-type!]
		frame  [pair!]									;-- current frame start, top
	][
		append logs reduce [
			event
			offset
			all [:ref mold/part/flat :ref 10]
			all [:value mold/part/flat :value 10]
			frame/y - frame/x
		]
	]

	check-diff: function [out [block!] expected [block!]][
		repeat i length? expected [
			if out/:i <> expected/:i [
				print ["** diff failed at:" mold/part at out i 80]
				print ["** expected :" mold/part at expected i 80]
				--assert false
				exit
			]
		]
		--assert true
	]

	--test-- "trace-1"
		clear logs
		--assert unset? do/trace [] :logger
		new-line/all/skip logs yes 5
		check-diff logs [
		    init -1 #[none] #[none] 2 
		    enter 0 #[none] #[none] 0 
		    exit 0 #[none] "unset" 0 
		    end -1 #[none] #[none] 3
		]

	--test-- "trace-2"
		clear logs
		--assert 123 = do/trace [123] :logger
		new-line/all/skip logs yes 5
		check-diff logs [
		    init -1 #[none] #[none] 2 
		    enter 0 #[none] #[none] 0 
		    fetch 0 #[none] "123" 0 
		    push 0 #[none] "123" 0 
		    expr 1 #[none] "123" 0
		    exit 1 #[none] "123" 0 
		    end -1 #[none] #[none] 3
		]

	--test-- "trace-3"
		clear logs
		--assert 6 = do/trace [1 + length? mold 'hello] :logger
		new-line/all/skip logs yes 5
		check-diff logs [
		    init -1 #[none] #[none] 2 
		    enter 0 #[none] #[none] 0 
		    fetch 0 #[none] "+" 0 
		    open 0 #[none] "+" 0 
		    fetch 0 #[none] "1" 0 
		    push 0 #[none] "1" 1 
		    fetch 2 #[none] "length?" 1 
		    open 3 #[none] "length?" 1 
		    fetch 3 #[none] "mold" 0 
		    open 4 #[none] "mold" 0 
		    fetch 4 #[none] "'hello" 0 
		    push 4 #[none] "hello" 1 
		    call 5 "mold" "make actio" 1 
		    return 5 "mold" {"hello"} 2 
		    call 5 "length?" "make actio" 1 
		    return 5 "length?" "5" 3 
		    call 5 "+" "make op! [" 2 
		    return 5 "+" "6" 2 
		    expr 5 #[none] "6" 1
		    exit 5 #[none] "6" 1 
		    end -1 #[none] #[none] 3
		]

	--test-- "trace-4"
		clear logs
		--assert 99 = do/trace [77 88 99] :logger
		new-line/all/skip logs yes 5
		check-diff logs [
		    init -1 #[none] #[none] 2 
		    enter 0 #[none] #[none] 0 
		    fetch 0 #[none] "77" 0 
		    push 0 #[none] "77" 0 
		    expr 1 #[none] "77" 0
		    fetch 1 #[none] "88" 0 
		    push 1 #[none] "88" 0 
		    expr 2 #[none] "88" 0
		    fetch 2 #[none] "99" 0 
		    push 2 #[none] "99" 0
		    expr 3 #[none] "99" 0
		    exit 3 #[none] "99" 0 
		    end -1 #[none] #[none] 3
		]

	--test-- "trace-5"
		clear logs
		--assert 'EVEN = do/trace [a: 4 either result: odd? a [print 'ODD]['EVEN]] :logger
		new-line/all/skip logs yes 5
		check-diff logs [
		    init -1 #[none] #[none] 2 
		    enter 0 #[none] #[none] 0 
		    fetch 0 #[none] "a:" 0 
		    push 0 #[none] "a:" 1 
		    fetch 1 #[none] "4" 1 
		    push 1 #[none] "4" 2 
		    set 2 "a:" "4" 2 
		    expr 2 #[none] "4" 1 
		    fetch 2 #[none] "either" 0 
		    open 3 #[none] "either" 0 
		    fetch 3 #[none] "result:" 0 
		    push 3 #[none] "result:" 1 
		    fetch 4 #[none] "odd?" 1 
		    open 5 #[none] "odd?" 1 
		    fetch 5 #[none] "a" 0 
		    push 5 #[none] "4" 0 
		    call 6 "odd?" "make actio" 1 
		    return 6 "odd?" #[none] 3 
		    set 6 "result:" #[none] 2 
		    fetch 6 #[none] "[print 'OD" 1 
		    push 6 #[none] "[print 'OD" 2 
		    fetch 7 #[none] "['EVEN]" 2 
		    push 7 #[none] "['EVEN]" 3 
		    call 8 "either" "make nativ" 3 
		    enter 0 #[none] #[none] 0 
		    fetch 0 #[none] "'EVEN" 0 
		    push 0 #[none] "EVEN" 0 
		    expr 1 #[none] "EVEN" 0 
		    exit 1 #[none] "EVEN" 0 
		    return 8 "either" "EVEN" 2 
		    expr 8 #[none] "EVEN" 1 
		    exit 8 #[none] "EVEN" 1 
		    end -1 #[none] #[none] 3
		]

	--test-- "trace-6"
		do [					;-- only interpreted functions will generate events
			fibo-tr6: func [n [integer!] return: [integer!]][
				either n < 1 [0][either n < 2 [1][(fibo-tr6 n - 2) + (fibo-tr6 n - 1)]]
			]
		]
		clear logs
		--assert 1 = do/trace [fibo-tr6 2] :logger
		new-line/all/skip logs yes 5
		check-diff logs [
		    init -1 #[none] #[none] 2 
		    enter 0 #[none] #[none] 0 
		    fetch 0 #[none] "fibo-tr6" 0 
		    open 1 #[none] "fibo-tr6" 0 
		    fetch 1 #[none] "2" 0 
		    push 1 #[none] "2" 1 
		    call 2 "fibo-tr6" "func [n [i" 1 
		    prolog -1 "fibo-tr6" "func [n [i" 1 
		    enter 0 #[none] #[none] 0 
		    fetch 0 #[none] "either" 0 
		    open 1 #[none] "either" 0 
		    fetch 1 #[none] "<" 0 
		    open 1 #[none] "<" 0 
		    fetch 1 #[none] "n" 0 
		    push 1 #[none] "2" 0 
		    fetch 3 #[none] "1" 1 
		    push 3 #[none] "1" 2 
		    call 4 "<" "make op! [" 2 
		    return 4 "<" #[none] 2  
		    fetch 4 #[none] "[0]" 1 
		    push 4 #[none] "[0]" 2 
		    fetch 5 #[none] "[either n " 2 
		    push 5 #[none] "[either n " 3 
		    call 6 "either" "make nativ" 3 
		    enter 0 #[none] #[none] 0 
		    fetch 0 #[none] "either" 0 
		    open 1 #[none] "either" 0 
		    fetch 1 #[none] "<" 0 
		    open 1 #[none] "<" 0 
		    fetch 1 #[none] "n" 0 
		    push 1 #[none] "2" 0 
		    fetch 3 #[none] "2" 1 
		    push 3 #[none] "2" 2 
		    call 4 "<" "make op! [" 2 
		    return 4 "<" #[none] 2  
		    fetch 4 #[none] "[1]" 1 
		    push 4 #[none] "[1]" 2 
		    fetch 5 #[none] "[(fibo-tr6" 2 
		    push 5 #[none] "[(fibo-tr6" 3 
		    call 6 "either" "make nativ" 3 
		    enter 0 #[none] #[none] 0 
		    fetch 0 #[none] "+" 0 
		    open 0 #[none] "+" 0 
		    fetch 0 #[none] "(fibo-tr6 " 0 
		    enter 0 #[none] #[none] 0 
		    fetch 0 #[none] "fibo-tr6" 0 
		    open 1 #[none] "fibo-tr6" 0 
		    fetch 1 #[none] "-" 0 
		    open 1 #[none] "-" 0 
		    fetch 1 #[none] "n" 0 
		    push 1 #[none] "2" 0 
		    fetch 3 #[none] "2" 1 
		    push 3 #[none] "2" 2 
		    call 4 "-" "make op! [" 2 
		    return 4 "-" "0" 2 
		    call 4 "fibo-tr6" "func [n [i" 1 
		    prolog -1 "fibo-tr6" "func [n [i" 1 
		    enter 0 #[none] #[none] 0 
		    fetch 0 #[none] "either" 0 
		    open 1 #[none] "either" 0 
		    fetch 1 #[none] "<" 0 
		    open 1 #[none] "<" 0 
		    fetch 1 #[none] "n" 0 
		    push 1 #[none] "0" 0 
		    fetch 3 #[none] "1" 1 
		    push 3 #[none] "1" 2 
		    call 4 "<" "make op! [" 2 
		    return 4 "<" "true" 2  
		    fetch 4 #[none] "[0]" 1 
		    push 4 #[none] "[0]" 2 
		    fetch 5 #[none] "[either n " 2 
		    push 5 #[none] "[either n " 3 
		    call 6 "either" "make nativ" 3 
		    enter 0 #[none] #[none] 0 
		    fetch 0 #[none] "0" 0 
		    push 0 #[none] "0" 0 
		    expr 1 #[none] "0" 0 
		    exit 1 #[none] "0" 0 
		    return 6 "either" "0" 2 
		    expr 6 #[none] "0" 1 
		    exit 6 #[none] "0" 1 
		    epilog -1 "fibo-tr6" "func [n [i" 2 
		    return 4 "fibo-tr6" "0" 2 
		    expr 4 #[none] "0" 1 
		    exit 4 #[none] "0" 1 
		    fetch 2 #[none] "(fibo-tr6 " 1 
		    enter 0 #[none] #[none] 0 
		    fetch 0 #[none] "fibo-tr6" 0 
		    open 1 #[none] "fibo-tr6" 0 
		    fetch 1 #[none] "-" 0 
		    open 1 #[none] "-" 0 
		    fetch 1 #[none] "n" 0 
		    push 1 #[none] "2" 0 
		    fetch 3 #[none] "1" 1 
		    push 3 #[none] "1" 2 
		    call 4 "-" "make op! [" 2 
		    return 4 "-" "1" 2 
		    call 4 "fibo-tr6" "func [n [i" 1 
		    prolog -1 "fibo-tr6" "func [n [i" 1 
		    enter 0 #[none] #[none] 0 
		    fetch 0 #[none] "either" 0 
		    open 1 #[none] "either" 0 
		    fetch 1 #[none] "<" 0 
		    open 1 #[none] "<" 0 
		    fetch 1 #[none] "n" 0 
		    push 1 #[none] "1" 0 
		    fetch 3 #[none] "1" 1 
		    push 3 #[none] "1" 2 
		    call 4 "<" "make op! [" 2 
		    return 4 "<" #[none] 2  
		    fetch 4 #[none] "[0]" 1 
		    push 4 #[none] "[0]" 2 
		    fetch 5 #[none] "[either n " 2 
		    push 5 #[none] "[either n " 3 
		    call 6 "either" "make nativ" 3 
		    enter 0 #[none] #[none] 0 
		    fetch 0 #[none] "either" 0 
		    open 1 #[none] "either" 0 
		    fetch 1 #[none] "<" 0 
		    open 1 #[none] "<" 0 
		    fetch 1 #[none] "n" 0 
		    push 1 #[none] "1" 0 
		    fetch 3 #[none] "2" 1 
		    push 3 #[none] "2" 2 
		    call 4 "<" "make op! [" 2 
		    return 4 "<" "true" 2 
		    fetch 4 #[none] "[1]" 1 
		    push 4 #[none] "[1]" 2 
		    fetch 5 #[none] "[(fibo-tr6" 2 
		    push 5 #[none] "[(fibo-tr6" 3 
		    call 6 "either" "make nativ" 3 
		    enter 0 #[none] #[none] 0 
		    fetch 0 #[none] "1" 0 
		    push 0 #[none] "1" 0 
		    expr 1 #[none] "1" 0 
		    exit 1 #[none] "1" 0 
		    return 6 "either" "1" 2 
		    expr 6 #[none] "1" 1 
		    exit 6 #[none] "1" 1 
		    return 6 "either" "1" 2 
		    expr 6 #[none] "1" 1 
		    exit 6 #[none] "1" 1 
		    epilog -1 "fibo-tr6" "func [n [i" 2 
		    return 4 "fibo-tr6" "1" 2 
		    expr 4 #[none] "1" 1 
		    exit 4 #[none] "1" 1 
		    call 3 "+" "make op! [" 2 
		    return 3 "+" "1" 2 
		    expr 3 #[none] "1" 1 
		    exit 3 #[none] "1" 1 
		    return 6 "either" "1" 2 
		    expr 6 #[none] "1" 1 
		    exit 6 #[none] "1" 1 
		    return 6 "either" "1" 2 
		    expr 6 #[none] "1" 1 
		    exit 6 #[none] "1" 1 
		    epilog -1 "fibo-tr6" "func [n [i" 2 
		    return 2 "fibo-tr6" "1" 2 
		    expr 2 #[none] "1" 1 
		    exit 2 #[none] "1" 1 
		    end -1 #[none] #[none] 3
		]

	--test-- "trace-7"
		do [					;-- only interpreted functions will generate events
			foo: function [a [integer!]][either result: odd? a ["ODD"]["EVEN"] result]
			bar: function [s [string!]][(length? s) + make integer! foo 1]
			baz: function [][bar "hello"]
		]
		clear logs
		--assert 6 = do/trace [baz] :logger
		new-line/all/skip logs yes 5
		check-diff logs [
		    init -1 #[none] #[none] 2 
		    enter 0 #[none] #[none] 0 
		    fetch 0 #[none] "baz" 0 
		    open 1 #[none] "baz" 0 
		    call 1 "baz" "func [][ba" 0 
		    prolog -1 "baz" "func [][ba" 0 
		    enter 0 #[none] #[none] 0 
		    fetch 0 #[none] "bar" 0 
		    open 1 #[none] "bar" 0 
		    fetch 1 #[none] {"hello"} 0 
		    push 1 #[none] {"hello"} 1 
		    call 2 "bar" "func [s [s" 1 
		    prolog -1 "bar" "func [s [s" 1 
		    enter 0 #[none] #[none] 0 
		    fetch 0 #[none] "+" 0 
		    open 0 #[none] "+" 0 
		    fetch 0 #[none] "(length? s" 0 
		    enter 0 #[none] #[none] 0 
		    fetch 0 #[none] "length?" 0 
		    open 1 #[none] "length?" 0 
		    fetch 1 #[none] "s" 0 
		    push 1 #[none] {"hello"} 0 
		    call 2 "length?" "make actio" 1 
		    return 2 "length?" "5" 2 
		    expr 2 #[none] "5" 1 
		    exit 2 #[none] "5" 1 
		    fetch 2 #[none] "make" 1 
		    open 3 #[none] "make" 1 
		    fetch 3 #[none] "integer!" 0 
		    push 3 #[none] "integer!" 0 
		    fetch 4 #[none] "foo" 1 
		    open 5 #[none] "foo" 1 
		    fetch 5 #[none] "1" 0 
		    push 5 #[none] "1" 1 
		    call 6 "foo" "func [a [i" 3 
		    prolog -1 "foo" "func [a [i" 3 
		    enter 0 #[none] #[none] 0 
		    fetch 0 #[none] "either" 0 
		    open 1 #[none] "either" 0 
		    fetch 1 #[none] "result:" 0 
		    push 1 #[none] "result:" 1 
		    fetch 2 #[none] "odd?" 1 
		    open 3 #[none] "odd?" 1 
		    fetch 3 #[none] "a" 0 
		    push 3 #[none] "1" 0 
		    call 4 "odd?" "make actio" 1 
		    return 4 "odd?" "true" 3 
		    set 4 "result:" "true" 2 
		    fetch 4 #[none] {["ODD"]} 1 
		    push 4 #[none] {["ODD"]} 2 
		    fetch 5 #[none] {["EVEN"]} 2 
		    push 5 #[none] {["EVEN"]} 3 
		    call 6 "either" "make nativ" 3 
		    enter 0 #[none] #[none] 0 
		    fetch 0 #[none] {"ODD"} 0 
		    push 0 #[none] {"ODD"} 0 
		    expr 1 #[none] {"ODD"} 0 
		    exit 1 #[none] {"ODD"} 0 
		    return 6 "either" {"ODD"} 2 
		    expr 6 #[none] {"ODD"} 1 
		    fetch 6 #[none] "result" 0 
		    push 6 #[none] "true" 0 
		    expr 7 #[none] "true" 0 
		    exit 7 #[none] "true" 0 
		    epilog -1 "foo" "func [a [i" 4 
		    return 6 "foo" "true" 3 
		    call 6 "make" "make actio" 2 
		    return 6 "make" "1" 3 
		    call 6 "+" "make op! [" 2 
		    return 6 "+" "6" 2 
		    expr 6 #[none] "6" 1 
		    exit 6 #[none] "6" 1 
		    epilog -1 "bar" "func [s [s" 2 
		    return 2 "bar" "6" 2 
		    expr 2 #[none] "6" 1 
		    exit 2 #[none] "6" 1 
		    epilog -1 "baz" "func [][ba" 1 
		    return 1 "baz" "6" 2 
		    expr 1 #[none] "6" 1 
		    exit 1 #[none] "6" 1 
		    end -1 #[none] #[none] 3
		]

	--test-- "trace-8"
		b: [x y z]
		i: 1
		j: 2
		clear logs
		--assert 'x == do/trace [b/:i]		:logger
		--assert 'x == do/trace [:b/:i]		:logger
		--assert 'z == do/trace [b/(i + j)]	:logger
		--assert 'A == do/trace [b/:i: 'A]	:logger
		--assert 'A == b/1
		new-line/all/skip logs yes 5
		check-diff logs [
		    init -1 #[none] #[none] 2 
		    enter 0 #[none] #[none] 0 
		    fetch 0 #[none] "b/:i" 0 
		    enter 0 #[none] #[none] 0 
		    fetch 0 #[none] "b" 0 
		    push 0 #[none] "[x y z]" 0 
		    fetch 1 #[none] ":i" 0 
		    push 1 #[none] "1" 0 
		    exit 2 #[none] "x" 0 
		    push 1 #[none] "x" 0 
		    expr 1 #[none] "x" 0 
		    exit 1 #[none] "x" 0 
		    end -1 #[none] #[none] 3 
		    init -1 #[none] #[none] 2 
		    enter 0 #[none] #[none] 0 
		    fetch 0 #[none] ":b/:i" 0 
		    enter 0 #[none] #[none] 0 
		    fetch 0 #[none] "b" 0 
		    push 0 #[none] "[x y z]" 0 
		    fetch 1 #[none] ":i" 0 
		    push 1 #[none] "1" 0 
		    exit 2 #[none] "x" 0 
		    push 0 #[none] "x" 0 
		    expr 1 #[none] "x" 0 
		    exit 1 #[none] "x" 0 
		    end -1 #[none] #[none] 3 
		    init -1 #[none] #[none] 2 
		    enter 0 #[none] #[none] 0 
		    fetch 0 #[none] "b/(i + j)" 0 
		    enter 0 #[none] #[none] 0 
		    fetch 0 #[none] "b" 0 
		    push 0 #[none] "[x y z]" 0 
		    fetch 1 #[none] "(i + j)" 0 
		    enter 0 #[none] #[none] 0 
		    fetch 0 #[none] "+" 0 
		    open 0 #[none] "+" 0 
		    fetch 0 #[none] "i" 0 
		    push 0 #[none] "1" 0 
		    fetch 2 #[none] "j" 1 
		    push 2 #[none] "2" 1 
		    call 3 "+" "make op! [" 2 
		    return 3 "+" "3" 2 
		    expr 3 #[none] "3" 1 
		    exit 3 #[none] "3" 1 
		    push 1 #[none] "3" 1 
		    exit 2 #[none] "z" 1 
		    push 1 #[none] "z" 0 
		    expr 1 #[none] "z" 0 
		    exit 1 #[none] "z" 0 
		    end -1 #[none] #[none] 3 
		    init -1 #[none] #[none] 2 
		    enter 0 #[none] #[none] 0 
		    fetch 0 #[none] "b/:i:" 0 
		    push 0 #[none] "b/:i:" 0 
		    fetch 1 #[none] "'A" 0 
		    push 1 #[none] "A" 1 
		    set 2 "b/:i:" "A" 1 
		    enter 0 #[none] #[none] 1 
		    fetch 0 #[none] "b" 1 
		    push 0 #[none] "[x y z]" 1 
		    fetch 1 #[none] ":i" 1 
		    push 1 #[none] "1" 1 
		    exit 2 #[none] "A" 1 
		    expr 2 #[none] "A" 1 
		    exit 2 #[none] "A" 1 
		    end -1 #[none] #[none] 3
		]

	--test-- "trace-9"
		do [foo-tr9: func [[trace]][1 + 2]]
		clear logs
		--assert 17 == do/trace [trace off 4 + 5 foo-tr9 8 + 9]	:logger
		new-line/all/skip logs yes 5
		check-diff logs [
		    init -1 #[none] #[none] 2 
		    enter 0 #[none] #[none] 0 
		    fetch 0 #[none] "trace" 0 
		    open 1 #[none] "trace" 0 
		    fetch 1 #[none] "off" 0 
		    push 1 #[none] #[none] 0 
		    call 2 "trace" "func [{Run" 7 
		    prolog -1 "foo-tr9" "func [[tra" 0 
		    enter 0 #[none] #[none] 0 
		    fetch 0 #[none] "+" 0 
		    open 0 #[none] "+" 0 
		    fetch 0 #[none] "1" 0 
		    push 0 #[none] "1" 1 
		    fetch 2 #[none] "2" 1 
		    push 2 #[none] "2" 2 
		    call 3 "+" "make op! [" 2 
		    return 3 "+" "3" 2
		    expr 3 #[none] "3" 1
		    exit 3 #[none] "3" 1 
		    epilog -1 "foo-tr9" "func [[tra" 1
    	]

	--test-- "trace-10"
		do [foo-tr10: func [[no-trace]][1 + 2]]
		clear logs
		--assert 15 == do/trace [4 + 5 foo-tr10 7 + 8] :logger
		new-line/all/skip logs yes 5
		check-diff logs [
		    init -1 #[none] #[none] 2 
		    enter 0 #[none] #[none] 0 
		    fetch 0 #[none] "+" 0 
		    open 0 #[none] "+" 0 
		    fetch 0 #[none] "4" 0 
		    push 0 #[none] "4" 1 
		    fetch 2 #[none] "5" 1 
		    push 2 #[none] "5" 2 
		    call 3 "+" "make op! [" 2 
		    return 3 "+" "9" 2 
		    expr 3 #[none] "9" 1
		    fetch 3 #[none] "foo-tr10" 0 
		    open 4 #[none] "foo-tr10" 0 
		    call 4 "foo-tr10" "func [[no-" 0 
		    return 4 "foo-tr10" "3" 2
		    expr 4 #[none] "3" 1
		    fetch 4 #[none] "+" 0 
		    open 4 #[none] "+" 0 
		    fetch 4 #[none] "7" 0 
		    push 4 #[none] "7" 1 
		    fetch 6 #[none] "8" 1 
		    push 6 #[none] "8" 2 
		    call 7 "+" "make op! [" 2 
		    return 7 "+" "15" 2
		    expr 7 #[none] "15" 1
		    exit 7 #[none] "15" 1 
		    end -1 #[none] #[none] 3
    	]

	--test-- "trace-11"
		b: [x y z] i: 1 j: 2
		clear logs
		--assert false == do/trace ['a = b/:j] :logger
		new-line/all/skip logs yes 5
		check-diff logs [
		    init -1 #[none] #[none] 2 
		    enter 0 #[none] #[none] 0 
		    fetch 0 #[none] "=" 0 
		    open 0 #[none] "=" 0 
		    fetch 0 #[none] "'a" 0 
		    push 0 #[none] "a" 1 
		    fetch 2 #[none] "b/:j" 1 
		    enter 0 #[none] #[none] 1 
		    fetch 0 #[none] "b" 1 
		    push 0 #[none] "[x y z]" 1 
		    fetch 1 #[none] ":j" 1 
		    push 1 #[none] "2" 1 
		    exit 2 #[none] "y" 1 
		    push 3 #[none] "y" 2 
		    call 3 "=" "make op! [" 2 
		    return 3 "=" #[none] 2
		    expr 3 #[none] #[none] 1
		    exit 3 #[none] #[none] 1 
		    end -1 #[none] #[none] 3
		]

		--test-- "trace-11"
			do [
				trace11: func [[no-trace] code][do/trace code does []]
				trace11 [trace11 []]
			]
			--assert true					;-- just check if it has not crashed

===end-group===

===start-group=== "reduce"

	--test-- "reduce-1"
		--assert [] = reduce []
		
	--test-- "reduce-2"
		--assert [] = do [reduce []]
		
	--test-- "reduce-3"
		--assert [123] = reduce [123]
		
	--test-- "reduce-4"
		--assert none = first reduce [none]
		
	--test-- "reduce-5"
		--assert false = first reduce [false]

	--test-- "reduce-6"
		--assert 'z = first reduce ['z]	
	
	--test-- "reduce-7"
		a: 123
		--assert [123 8 z] = reduce [a 3 + 5 'z]
	
	--test-- "reduce-8"
		blk: [a b c]
		--assert [a b c] = reduce/into [3 + 4 a] blk
		--assert blk = [7 123 a b c]
	
	--test-- "reduce-9"
		a: 123
		--assert [123 8 z] = do [reduce [a 3 + 5 'z]]
	
	--test-- "reduce-10"
		blk: [a b c]
		--assert [a b c] = do [reduce/into [3 + 4 a] blk]
		--assert blk = [7 123 a b c]

	--test-- "reduce-11"
		code: [1 + 3 a 'z append "hell" #"o"]
		--assert [4 123 z "hello"] = reduce code
	
	--test-- "reduce-11"
		code: [1 + 3 a 'z append "hell" #"o"]
		--assert [4 123 z "hello"] = do [reduce code]

	--test-- "reduce-12"
		--assert none = reduce none

	--test-- "reduce-13"
		--assert none = do [reduce none]
		
	--test-- "reduce-14"
		--assert [[]] = reduce [reduce []]
	
	--test-- "reduce-15"
		--assert [3 z] = reduce [
			1 + length? reduce [3 + 4 789] 'z
		]
	
	--test-- "reduce-16"
		--assert [[]] = do [reduce [reduce []]]
	
	--test-- "reduce-17"
		--assert [3 z] = do [
			reduce [
				1 + length? reduce [3 + 4 789] 'z
			]
		]
		
	--test-- "reduce-18"
		a: [3 + 4]
		--assert [7] = reduce a
		--assert [7] = do [reduce a]

	--test-- "reduce-19"
		b: next [1 2]
		--assert [2] = reduce/into [yes 3 4 5] b
		--assert [1 #[true] 3 4 5 2] = head b

	--test-- "reduce-20"
		b: 2
		--assert [2] = head reduce/into b []
		--assert ["a"] = head reduce/into "a" []

===end-group===

===start-group=== "compose"
	
	--test-- "compose-1"
	--assert  [] = compose []
	--assert  [] = compose/deep []
	--assert  [] = compose/deep/only []
	--assert  [] = do [compose []]
	--assert [] = do [compose/deep []]
	--assert [] = do [compose/deep/only []]
	
	--test-- "compose-2"
	--assert [1 [2] "3" a 'b c: :d] = compose [1 [2] "3" a 'b c: :d]
	--assert [1 [2] "3" a 'b c: :d] = do [compose [1 [2] "3" a 'b c: :d]]
	
	--test-- "compose-3"
	--assert [1] = compose [(1)]
	--assert [1] = do [compose [(1)]]
	
	--test-- "compose-4"
	--assert none == first compose [(none)]
	--assert none == first do [compose [(none)]]

	--test-- "compose-5"
	--assert true == first compose [(true)]
	--assert true == first do [compose [(true)]]
	
	--test-- "compose-6"
	--assert [3] = compose [(1 + 2)]
	--assert [3] = do [compose [(1 + 2)]]
	
	--test-- "compose-7"
	--assert [x 9 y] = compose [x (4 + 5) y]
	--assert [x 9 y] = do [compose [x (4 + 5) y]]
	
	--test-- "compose-8"
	--assert [] = compose [([])]
	--assert [] = do [compose [([])]]
	
	--test-- "compose-9"
	--assert [[]] = compose/only [([])]
	--assert [[]] = do [compose/only [([])]]
	
	--test-- "compose-10"
	--assert [1 2 3] = compose [([1 2 3])]
	--assert [1 2 3] = do [compose [([1 2 3])]]
	
	--test-- "compose-11"
	--assert [1 2 3] = compose [([1 2 3])]
	--assert [1 2 3] = do [compose [([1 2 3])]]
	
	--test-- "compose-12"
	--assert [[(5 + 6)]] = compose [[(5 + 6)]]
	--assert [[(5 + 6)]] = do [compose [[(5 + 6)]]]
	
	--test-- "compose-13"
	--assert [[1]] = compose/deep [[(7 - 6)]]
	--assert [[1]] = do [compose/deep [[(7 - 6)]]]
	
	--test-- "compose-14"
	--assert [[]] = compose/deep [[([])]]
	--assert [[]] = do [compose/deep [[([])]]]
	
	--test-- "compose-15"
	--assert [[[]]] = compose/deep/only [[([])]]
	--assert [[[]]] = do [compose/deep/only [[([])]]]
	
	--test-- "compose-16"
	--assert [[8] x [9] y] = compose/deep [[(2 + 6)] x [(4 + 5)] y]
	--assert [[8] x [9] y] = do [compose/deep [[(2 + 6)] x [(4 + 5)] y]]
	
	--test-- "compose-17"
	--assert [a 3 b 789 1 2 3] = compose [a (1 + 2) b () (print "") ([]) 789 ([1 2 3])]
	--assert [a 3 b 789 1 2 3] = compose [a (1 + 2) b () (print "") ([]) 789 ([1 2 3])]

	--test-- "compose-18"
	--assert [a 3 b [] 789 [1 2 3]] = compose/only [a (1 + 2) b () (print "") ([]) 789 ([1 2 3])]
	--assert [a 3 b [] 789 [1 2 3]] = compose/only [a (1 + 2) b () (print "") ([]) 789 ([1 2 3])]
	
	--test-- "compose-19"
	--assert [a [3] 8 b [2 3 [x "hello" x]]] = compose/deep [
		a [(1 + 2)] (9 - 1) b [
			2 3 [x (append "hell" #"o") x]
		]
	]
	--assert [a [3] 8 b [2 3 [x "hello" x]]] = do [		;; refinements not supported yet by DO
		compose/deep [
			a [(1 + 2)] (9 - 1) b [
				2 3 [x (append "hell" #"o") x]
			]
		]
	]

	--test-- "compose-20"
	a: [1 2 3]
	--assert [1 2 3] = compose/into [r (1 + 6)] a
	--assert a = [r 7 1 2 3]
	a: [1 2 3]
	--assert [1 2 3] = do [compose/into [r (1 + 6)] a]
	--assert a = [r 7 1 2 3]
	
	--test-- "compose-21"
	a: [(mold 2 + 3)]
	--assert ["5"] = compose a
	--assert ["5"] = do [compose a]

	--test-- "compose-22"
	b: next [1 2]
	--assert [2] = compose/into [no 7 8 9 (2 * 10) ([5 6])] b
	--assert [1 no 7 8 9 20 5 6 2] = head b

===end-group===

===start-group=== "unset value passing"

	--test-- "unset-1"
		--assert unset! = type? set/any 'xyz ()
		--assert unset! = type? get/any 'xyz
		--assert unset! = type? :xyz

	--test-- "unset-2"
		test-unset: has [zyx][
			--assert unset! = type? set/any 'zyx ()
			--assert unset! = type? get/any 'zyx
			--assert unset! = type? :zyx
		]
		test-unset

===end-group===

===start-group=== "SET tests"

	--test-- "set-1"
		--assert 123 = set 'value 123
		--assert value = 123
		
	--test-- "set-2"
		--assert 456 = set [A B] 456
		--assert a = 456
		--assert b = 456
		
	--test-- "set-3"
		--assert [7 8] = set [A B] [7 8]
		--assert a = 7
		--assert b = 8
		
	--test-- "set-4"
		--assert [4 5] = set/only [A B] [4 5]
		--assert a = [4 5]
		--assert b = [4 5]
		
	--test-- "set-5"
		--assert [4 #[none]] = set [A B] reduce [4 none]
		--assert a = 4
		--assert b = none
		
	--test-- "set-6"
		b: 789
		--assert [4 #[none]] = set/some [A B] reduce [4 none]
		--assert a = 4
		--assert b = 789

	--test-- "set-7"
		obj: object [a: 1 b: 2]
		--assert [4 5] = set obj [4 5]
		--assert obj/a = 4
		--assert obj/b = 5

	--test-- "set-8"
		obj:  object [a: 3 b: 4]
		obj2: object [z: 0 a: 6 b: 7 c: 9]
		--assert obj2 = set obj obj2
		--assert "make object! [a: 6 b: 7]" = mold/flat obj
		--assert "make object! [z: 0 a: 6 b: 7 c: 9]" = mold/flat obj2
		
	--test-- "set-9"
		obj:  object [a: 3 b: 4]
		obj2: object [z: 0]
		--assert obj2 = set/only obj obj2
		--assert obj/a = obj2
		--assert obj/b = obj2
		
	--test-- "set-10"
		obj:  object [a: 3 b: 4]
		obj2: object [z: 0 a: none b: 7]
		--assert obj2 = set obj obj2
		--assert "make object! [a: none b: 7]" = mold/flat obj
		--assert "make object! [z: 0 a: none b: 7]" = mold/flat obj2

	--test-- "set-11"
		obj:  object [a: 3 b: 4]
		obj2: object [z: 0 a: none b: 7]
		--assert obj2 = set/some obj obj2
		--assert "make object! [a: 3 b: 7]" = mold/flat obj
		--assert "make object! [z: 0 a: none b: 7]" = mold/flat obj2
	
	--test-- "set-12"
		a: 1
		b: 2
		--assert to logic! all [
			error? try [set [a b] ()]
			a == 1 b == 2
		]
	
	--test-- "set-13"
		a: 1
		b: 2
		set/any [a b] ()
		--assert all [unset? :a unset? :b]
	
	--test-- "set-14"
		a: 1
		b: 2
		--assert to logic! all [
			error? try [set [a b] reduce [3 ()]]
			a == 1 b == 2
		]
	
	--test-- "set-15"
		a: 1
		b: 2
		set/any [a b] reduce [3 ()]
		--assert to logic! all [a == 3 unset? :b]

	--test-- "set-16"
		obj:  object [a: 1 b: 2]
		obj2: object [a: 3 b: 4]
		unset in obj2 'b
		--assert to logic! all [
			error? try [set obj obj2]
			"make object! [a: 1 b: 2]" = mold/flat obj
		]
	
	--test-- "set-17"
		obj:  object [a: 1 b: 2]
		obj2: object [a: 3 b: 4]
		unset in obj2 'b
		set/any obj obj2
		--assert "make object! [a: 3 b: unset]" = mold/flat obj
	
	--test-- "set-18"
		obj: object [a: 1 b: 2]
		--assert to logic! all [
			error? try [set obj ()]
			"make object! [a: 1 b: 2]" = mold/flat obj
		]
	
	--test-- "set-19"
		obj: object [a: 1 b: 2]
		set/any obj ()
		--assert "make object! [a: unset b: unset]" = mold/flat obj
	
	--test-- "set-20"
		obj: object [a: 1 b: 2]
		blk: reduce [3 ()]
		--assert to logic! all [
			error? try [set obj blk]
			"make object! [a: 1 b: 2]" = mold/flat obj
		]
	
	--test-- "set-21"
		obj: object [a: 1 b: 2]
		blk: reduce [3 ()]
		set/any obj blk
		--assert "make object! [a: 3 b: unset]" = mold/flat obj
	
	
	--test-- "set-22"
		k: 1
		v: 2
		map: #(a: 3)
		map/a: ()
		--assert to logic! all [
			error? try [set [k v] map]
			k == 1 v == 2
		]
	
	--test-- "set-23"
		k: 1
		v: 2
		map: #(a: 3)
		map/a: ()
		set/any [k v] map
		--assert to logic! all [k == to set-word! 'a unset? :v]
	
	--test-- "set-24"
		do [								;-- compiler detects malformed set block
			a: 1
			b: 2
			e: try [set/any [a 1 b] reduce [3 4 ()]]
			--assert to logic! all [
				error? e
				e/id == 'invalid-arg
				e/arg1 == 1					;-- 1 is an integer, not a word
				a == 1 b == 2
			]
		]
	
	--test-- "set-25"
		do [								;-- compiler detects malformed set block
			a: 1
			b: 2
			e: try [set [a b 1] reduce [3 () 4]]
			--assert to logic! all [
				error? e
				e/id == 'need-value
				e/arg1 == 'b				;-- b needs a value
				a == 1 b == 2
			]
		]
	
	--test-- "set-26"
		a: none
		b: none
		c: none
		set [a b c][1 2]
		--assert to logic! all [a == 1 b == 2 c == none]
	
	--test-- "set-27"
		a: none
		b: none
		c: 3
		set [a b][1 2 4]
		--assert to logic! all [a == 1 b == 2 c == 3]
	
	--test-- "set-28"						;-- compiler detects malformed set block
		--assert do [error? try [set [a/b] 1]]
		--assert do [error? try [set [a/b: :c/d] [1 2]]]

	--test-- "set-29"
		obj: object [a: 0]
		
		set quote obj/a 1
		--assert 1 == get quote obj/a
		
		set quote 'obj/a 2
		--assert 2 == get quote 'obj/a
		
		set quote :obj/a 3
		--assert 3 == get quote :obj/a
		
		set quote obj/a: 4
		--assert 4 == get quote obj/a:
	
	--test-- "set-30"								;-- extra tests to see how compiler handles GET-PATH!s
		obj: object [a: 0]
		
		set to get-path! 'obj/a 1
		--assert 1 == get to get-path! 'obj/a
		
		set first [:obj/a] 2
		--assert 2 == get first [:obj/a]
		
		set load ":obj/a" 3
		--assert 3 == get load ":obj/a"
	
===end-group===

~~~end-file~~~
