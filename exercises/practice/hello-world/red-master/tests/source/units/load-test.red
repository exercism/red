Red [
	Title:   "Red loading test script"
	Author:  "Nenad Rakocevic & Peter W A Wood"
	File: 	 %load-test.red
	Tabs:	 4
	Rights:  "Copyright (C) 2011-2015 Red Foundation. All rights reserved."
	License: "BSD-3 - https://github.com/red/red/blob/origin/BSD-3-License.txt"
]

#include  %../../../quick-test/quick-test.red

~~~start-file~~~ "load"

===start-group=== "Delimiter LOAD tests"

	--test-- "load-1"  --assert "" 		 = load {""}
	--test-- "load-2"  --assert "" 		 = load {{}}
	--test-- "load-3"  --assert "{" 	 = load {"^{"}
	--test-- "load-4"  --assert "}" 	 = load {"^}"}
	--test-- "load-5"  --assert "{}"	 = load {"^{^}"}
	--test-- "load-6"  --assert {^}^{} 	 = load {"^}^{"}
	--test-- "load-7"  --assert "^{^}^}" = load {"^{^}^}"}
	--test-- "load-8"  --assert ""		 = load {"^"}
	--test-- "load-9"  --assert ""		 = load "{}"
	--test-- "load-10" --assert "{"		 = load "{^^{}"
	--test-- "load-11" --assert {"}		 = load {{"}}
	--test-- "load-12" --assert "^/" 	 = load "{^/}^/"
	--test-- "load-13" --assert "^/" 	 = load "{^/}"
	--test-- "load-14" --assert "{^/}"	 = load {{{^/}}}
	--test-- "load-15" --assert {{"x"}}	 = load {{{"x"}}}
	--test-- "load-16" --assert "{x}"	 = load {{{x}}}
	--test-- "load-17" --assert {"x"}	 = load {{"x"}}
	--test-- "load-18" --assert "x"		 = load {{x}}
	
===end-group===

===start-group=== "LOAD /part tests"
	src: "123abc789"

	--test-- "load-p1" --assert 123  = load/part src 3
	--test-- "load-p2" --assert 12   = load/part src 2
	--test-- "load-p3" --assert 1    = load/part src 1
	--test-- "load-p4" --assert []   = load/part src 0
	--test-- "load-p4" --assert 'abc = load/part skip src 3 3

===end-group===
 
===start-group=== "LOAD floats test"

	--test-- "load-30"	--assert "123.0"		= mold load "123.0"
	--test-- "load-31"	--assert "1.123"		= mold load "1.123"
	--test-- "load-32"	--assert "0.123"		= mold load ".123"
	--test-- "load-33"	--assert "100.0"		= mold load "1E2"
	--test-- "load-34"	--assert "1200.0"		= mold load "1.2E3"
	--test-- "load-35"	--assert "10.0"			= mold load ".1E2"
	--test-- "load-36"	--assert "12.3"			= mold load ".123E2"
	--test-- "load-37"	--assert "-0.3"			= mold load "-.3"
	--test-- "load-38"	--assert "1.#NaN"		= mold load "1.#nan"
	--test-- "load-39"	--assert "1.#NaN"		= mold load "-1.#nan"
	--test-- "load-40"	--assert "1.#NaN"		= mold load "+1.#nan"
	--test-- "load-41"	--assert "1.#INF"		= mold load "1.#INF"
	--test-- "load-42"	--assert "-1.#INF"		= mold load "-1.#Inf"
	--test-- "load-43"	--assert "1.#INF"		= mold load "+1.#Inf"
	--test-- "load-44"	--assert "1.0e23"		= mold load "0.99999999999999999999999999999999999999999e+23"
	--test-- "load-45"	--assert "-9.3e-9"		= mold load "-93E-10"
	--test-- "load-46"	--assert "0.0"			= mold load "2183167012312112312312.23538020374420446192e-370"
	--test-- "load-47"	--assert 1.3			== load "1,3"
	--test-- "load-48"	--assert 2147483648.0	== load "2147483648"
	--test-- "load-49"	--assert -2147483649.0	== load "-2147483649"
	;-- issue #3243
	f3243: 11.651178950846456
	--test-- "load-50"	--assert f3243 == load mold f3243

===end-group===

===start-group=== "Load percent tests"

	;-- for issue #3435 (1.#INF and 1.#NaN values corrupts percentage value scanner)
	--test-- "load-percent-1"	--assert "1.#NaN" = mold load "1.#nan"
	--test-- "load-percent-2"	--assert 1% == load "1%"

	;-- for issue #3449 (compile lexer reads percent! as an issue!)
	--test-- "load-percent-3"	--assert -10% == load "-10%"
	
===end-group===

===start-group=== "Load integer tests"

	--test-- "load-int-1"	--assert 0 == load "0"
	--test-- "load-int-2"	--assert 2147483647 == load "2147483647"
	--test-- "load-int-3"	--assert -2147483648 == load "-2147483648"
	--test-- "load-int-4"	--assert error? try [load "1a3"]
	--test-- "load-int-5"	--assert 1 == load "1"
	--test-- "load-int-6"	--assert 1 == load "+1"
	--test-- "load-int-7"	--assert -1 == load "-1"
	--test-- "load-int-8"	--assert 0 == load "+0"
	--test-- "load-int-9"	--assert 0 == load "-0"
	--test-- "load-int-10"	--assert 1 == load "01h"
	--test-- "load-int-11"	--assert 2147483647 == load "7FFFFFFFh"
	--test-- "load-int-12"	--assert -1 == load "FFFFFFFFh"
	
===end-group===

===start-group=== "load word tests"

	--test-- "load-word-1"	--assert 'w == load "w"
	--test-- "load-word-2"	--assert '? == load "?"
	--test-- "load-word-3"	--assert '! == load "!"
	--test-- "load-word-4"	--assert '. == load "."
	--test-- "load-word-5"	--assert 'a' == load "a'"  	
	--test-- "load-word-6"	--assert '+ == load "+"
	--test-- "load-word-7"	--assert '- == load "-"
	--test-- "load-word-8"	--assert '* == load "*"
	--test-- "load-word-9"	--assert '& == load "&"
	--test-- "load-word-10"	--assert '| == load "|"
	--test-- "load-word-11"	--assert '= == load "="
	--test-- "load-word-12"	--assert '_ == load "_"
	--test-- "load-word-13" --assert '~ == load "~"
	--test-- "load-word-14" --assert 'a == load "a;b"
	--test-- "load-word-15"	--assert 'a/b == load "a/b"
	--test-- "load-word-16" --assert strict-equal? first [a:] load "a:"
	--test-- "load-word-17"	--assert strict-equal? first [:a] load ":a"
	--test-- "load-word-18"	--assert strict-equal? first ['a] load "'a"
	--test-- "load-word-19" --assert strict-equal? first [œ∑´®†] load "œ∑´®†"
	--test-- "load-word-20" --assert word? load "//"
	
===end-group===

===start-group=== "load binaries tests"

	--test-- "load-bin-1"
		src: "2#{00001111}"
		--assert #{0F} = load src

	--test-- "load-bin-2"
		src: "2#{0000 11 11}"
		--assert #{0F} = load src

	--test-- "load-bin-3"
		src: {
		2#{
		00 1 1
		11
		01

		}}
		--assert #{3D} = load src

===end-group===

===start-group=== "load code tests"
	--test-- "load-code-1"	--assert [a ()] == load "a()"
	--test-- "load-code-2"	--assert [a []] == load "a[]"
	--test-- "load-code-3"	--assert [a {}] == load "a{}"
	--test-- "load-code-4"	--assert [a ""] == load {a""}
===end-group=== 

===start-group=== "load map tests"

	--test-- "load-map-1"
		lm1-blk: load "m: #(a: 1 b: 2)"
		--assert 2 == length? lm1-blk
		--assert strict-equal? first [m:] first lm1-blk
		--assert map! = type? second lm1-blk
		--assert 2 == length? second lm1-blk
		--assert 1 == select second lm1-blk first [a:]
		--assert 2 == select second lm1-blk first [b:]
		
	--test-- "load-map-2"
		lm2-blk: load "m: make map! [a: 1 b: 2]"
		--assert 4 == length? lm2-blk
		--assert strict-equal? first [m:] first lm2-blk
		--assert 'make == second lm2-blk
		--assert 'map! == third lm2-blk
		--assert 4 == length? fourth lm2-blk
		--assert 1 == select fourth lm2-blk first [a:]
		--assert 2 == select fourth lm2-blk first [b:]

===end-group===

===start-group=== "load object tests"

	--test-- "load-object-1"
		lo1-blk: load {
			o: make object! [
				a: 1
				b: 1.0
				c: #"1"
				d: "one"
				e: #(a: 1 b: 2)
				f: func [][1]
			]
		}
		--assert block! = type? lo1-blk
		--assert 4 = length? lo1-blk
		--assert strict-equal?
			first [o:]
			first lo1-blk
		--assert 'make == second lo1-blk
		--assert 'object! == third lo1-blk
		--assert 14 == length? fourth lo1-blk
		--assert strict-equal?
			first [a:]
			first fourth lo1-blk
		--assert 1 == second fourth lo1-blk
		--assert strict-equal?
			first [b:]
			third fourth lo1-blk
		--assert 1.0 == fourth fourth lo1-blk
		--assert strict-equal?
			first [c:]
			fifth fourth lo1-blk
		--assert #"1" == pick fourth lo1-blk 6
		--assert strict-equal?
			first [d:]
			pick fourth lo1-blk 7
		--assert "one" == pick fourth lo1-blk 8
		--assert strict-equal?
			first [e:]
			pick fourth lo1-blk 9
		--assert map! == type? pick fourth lo1-blk 10
		--assert 1 == select pick fourth lo1-blk 10 'a
		--assert 2 == select pick fourth lo1-blk 10 'b
		--assert strict-equal?
			first [f:]
			pick fourth lo1-blk 11
		--assert 'func == pick fourth lo1-blk 12
		--assert [] == pick fourth lo1-blk 13
		--assert [1] == pick fourth lo1-blk 14
		
	--test-- "load-object-2"
		lo2-blk: load {
			o: make object! [
				oo: make object! [
					ooo: make object! [
						a: 1
					]
				]
			]
		}
		--assert 4 == length? lo2-blk
		--assert 4 == length? fourth lo2-blk
		--assert 4 == length? fourth fourth lo2-blk
		--assert 2 == length? fourth fourth fourth lo2-blk
		--assert strict-equal?
			first [o:]
			first lo2-blk
		--assert 'make == second lo2-blk
		--assert 'object! == third lo2-blk
		--assert strict-equal?
			first [oo:]
			first fourth lo2-blk
		--assert 'make == second fourth lo2-blk
		--assert 'object! == third fourth lo2-blk
		--assert strict-equal?
			first [ooo:]
			first fourth fourth lo2-blk
		--assert 'make == second fourth fourth lo2-blk
		--assert 'object! == third fourth fourth lo2-blk
		--assert strict-equal?
			first [a:]
			first fourth fourth fourth lo2-blk
		--assert 1 == second fourth fourth fourth lo2-blk

===end-group===

===start-group=== "load date tests"

	--test-- "load-date-1"	--assert 3-Mar-0000/13:44:24+09:45  = load "3-Mar-0000/13:44:24+09:45"
	--test-- "load-date-2"	--assert 14-Jan-2046/9:34:48-12:15  = load "14-Jan-2046/9:34:48-12:15"
	--test-- "load-date-3"	--assert 19-Nov-4262/9:41:12-01:30  = load "19-Nov-4262/9:41:12-01:30"
	--test-- "load-date-4"	--assert 12-Feb-1864/3:26:00-14:30  = load "12-Feb-1864/3:26:00-14:30"
	--test-- "load-date-5"	--assert 29-Jul-4351/8:14:00+09:30  = load "29-Jul-4351/8:14:00+09:30"
	--test-- "load-date-6"	--assert 18-Dec-1884/22:30:48-07:00 = load "18-Dec-1884/22:30:48-07:00"
	--test-- "load-date-7"	--assert 21-May-5509/0:14:24-03:00  = load "21-May-5509/0:14:24-03:00"
	--test-- "load-date-8"	--assert 23-Apr-4622/4:22:48+05:30  = load "23-Apr-4622/4:22:48+05:30"
	--test-- "load-date-9"	--assert 22-Feb-1583/16:36:48-14:45 = load "22-Feb-1583/16:36:48-14:45"
	--test-- "load-date-10"	--assert 26-Feb-6712/17:07:12-10:00 = load "26-Feb-6712/17:07:12-10:00"

===end-group===

===start-group=== "load next tests"

	--test-- "load-next-1"
		s: "123 []hello"
		--assert 123 	== load/next s 's
		--assert [] 	== load/next s 's
		--assert 'hello == load/next s 's
		--assert [] 	== load/next s 's
		--assert [] 	== load/next s 's
		--assert (head s) == "123 []hello"

	--test-- "load-next-2"
		s: "{}()[]"
		--assert "" 			 == load/next s 's
		--assert (make paren! 0) == load/next s 's
		--assert [] 			 == load/next s 's

	--test-- "load-next-3"
		s: "^-{}^/(^/)^M[^-]"
		--assert "" 			 == load/next s 's
		--assert (make paren! 0) == load/next s 's
		--assert [] 			 == load/next s 's

===end-group===

;;  OBSOLETE test related to a specific lexer implementation.
;===start-group=== "load issue #2438"
;
;	--test-- "load a<=>"
;		--assert error? res: try [load "a<=>"]
;		--assert to logic! find/match form res {*** Syntax Error: invalid word! at "a<=>"^/*** Where:}
;
;	--test-- "load a</=>"
;		--assert not error? res: try [load "a</=>"]
;		--assert word? :res/1
;		--assert tag?  :res/2
;
;===end-group===

===start-group=== "load issue #3717"
	--test-- "load ) 1"
		--assert error? res: try [load ")"]
		--assert to logic! find/match form res {*** Syntax Error: (line 1) missing ( at )^/*** Where}

	--test-- "load ) 2"
		--assert error? res: try [load "a)"]
		--assert to logic! find/match form res {*** Syntax Error: (line 1) missing ( at )^/*** Where}

	--test-- "load ) 3"
		--assert error? res: try [load "a)b"]
		--assert to logic! find/match form res {*** Syntax Error: (line 1) missing ( at )b^/*** Where}

	--test-- "load ) 4"
		--assert error? res: try [load "())b"]
		--assert to logic! find/match form res {*** Syntax Error: (line 1) missing ( at )b^/*** Where}

	;--test-- "load ) 5"
	;	res: load/trap "())b"
	;	--assert [()] = res/1
	;	--assert "b" = res/2
	;	--assert to logic! find/match form res/3 {*** Syntax Error: (line 1) missing ( at )b^/*** Where}

	--test-- "load ) 6"
		s: "())b"
		--assert [()] = load/all/next s 's
		--assert ")b" = s
		--assert error? try [load/all/next s 's]

	--test-- "load ) 7"
		--assert error? try [transcode/next to-binary ")"]

	--test-- "load ] 1"
		--assert error? res: try [load "]"]
		--assert to logic! find/match form res {*** Syntax Error: (line 1) missing [ at ]^/*** Where}

	--test-- "load ] 2"
		--assert error? res: try [load "a]"]
		--assert to logic! find/match form res {*** Syntax Error: (line 1) missing [ at ]^/*** Where}

	--test-- "load ] 3"
		--assert error? res: try [load "a]b"]
		--assert to logic! find/match form res {*** Syntax Error: (line 1) missing [ at ]b^/*** Where}

	--test-- "load ] 4"
		--assert error? res: try [load "[]]b"]
		--assert to logic! find/match form res {*** Syntax Error: (line 1) missing [ at ]b^/*** Where}

	;--test-- "load ] 5"
	;	res: load/trap "[]]b"
	;	--assert [[]] = res/1
	;	--assert "b" = res/2
	;	--assert to logic! find/match form res/3 {*** Syntax Error: (line 1) missing [ at ]b^/*** Where}

	--test-- "load ] 6"
		s: "[]]b"
		--assert [[]] = load/all/next s 's
		--assert "]b" = s
		--assert error? try [load/all/next s 's]

	--test-- "load ] 7"
		--assert error? try [transcode/next "]"]

	--test-- "load } 1"
		--assert error? res: try [load "}"]
		--assert to logic! find/match form res {*** Syntax Error: (line 1) invalid character at ^}^/*** Where}

	--test-- "load } 2"
		--assert error? res: try [load "a}"]
		--assert to logic! find/match form res {*** Syntax Error: (line 1) invalid character at ^}^/*** Where}

	--test-- "load } 3"
		--assert error? res: try [load "a}b"]
		--assert to logic! find/match form res {*** Syntax Error: (line 1) invalid character at ^}b^/*** Where}

	--test-- "load } 4"
		--assert error? res: try [load "{}}b"]
		--assert to logic! find/match form res {*** Syntax Error: (line 1) invalid character at ^}b^/*** Where}

	;--test-- "load } 5"
	;	res: load/trap "{}}b"
	;	--assert [""] = res/1
	;	--assert "b" = res/2
	;	--assert to logic! find/match form res/3 {*** Syntax Error: (line 1) invalid character at ^}b^/*** Where}

	--test-- "load } 6"
		s: "{}}b"
		--assert [""] = load/all/next s 's
		--assert "}b" = s
		--assert error? try [load/all/next s 's]

	--test-- "load } 7"
		--assert error? try [transcode/next "}"]

===end-group===

===start-group=== "load issues"

	--test-- "#5043"
		b: [1 2]
		--assert [1 2 3 4] = load/into "3 4" b

===end-group===

~~~end-file~~~
