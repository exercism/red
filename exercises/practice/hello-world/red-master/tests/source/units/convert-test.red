Red [
	Title:   "Red TO action test script"
	Author:  ["Oldes" "Peter W A Wood"]
	File: 	 %convert-test.red
	Tabs:	 4
	Rights:  "Copyright (C) 2011-2017 Red Foundation. All rights reserved."
	License: "BSD-3 - https://github.com/dockimbel/Red/blob/origin/BSD-3-License.txt"
]

#include  %../../../quick-test/quick-test.red

~~~start-file~~~ "to"

===start-group=== "to-char!"

	--test-- "to-char!-char!"		--assert #"a" = to char! #"a"
	--test-- "to-char!-string!"		--assert #"f" = to char! "foo"
	--test-- "to-char!-integer!"		--assert #"{" = to char! 123
	--test-- "to-char!-integer!"		--assert #"Ā" = to char! 256
	--test-- "to-char!-float!"		--assert #"^A" = to char! 1.5
	--test-- "to-char!-binary!"		--assert #"a" = to char! #{616263}
	
===end-group===

===start-group=== "to-string!"

	--test-- "to-string!-char!"		--assert "a" = to string! #"a"
	--test-- "to-string!-string!"		--assert "foo" = to string! "foo"
	--test-- "to-string!-integer!-1"	--assert "123" = to string! 123
	--test-- "to-string!-integer!-2"	--assert "256" = to string! 256
	--test-- "to-string!-float!"		--assert "1.5" = to string! 1.5
	--test-- "to-string!-integer!"		--assert "-1" = to string! -1
	--test-- "to-string!-float!"		--assert "-1.5" = to string! -1.5
	--test-- "to-string!-pair!"		--assert "1x2" = to string! 1x2
	--test-- "to-string!-word!"		--assert "word" = to string! 'word
	--test-- "to-string!-refinement!"	--assert "refinement" = to string! /refinement
	--test-- "to-string!-path!"		--assert "path/foo" = to string! 'path/foo
	--test-- "to-string!-url!"		--assert "http://red-lang.org" = to string! http://red-lang.org
	--test-- "to-string!-file!"		--assert "/file/" = to string! %/file/
	--test-- "to-string!-issue!"		--assert "FF00" = to string! #FF00
	--test-- "to-string!-binary!-1"		--assert "" = to string! #{}
	--test-- "to-string!-binary!-2"		--assert "abc" = to string! #{616263}
	--test-- "to-string!-binary!-3"		--assert error? try [to-string #{62C3}]
	--test-- "to-string!-block!-1"		--assert "" = to string! []
	--test-- "to-string!-block-2!"		--assert "12" = to string! [1 2]
	--test-- "to-string!-block!-3"		--assert "123" = to string! [1 2 3]
	--test-- "to-string!-block!-4"		--assert "ab" = to string! ["a" "b"]
	--test-- "to-string!-tuple!"		--assert "1.1.1" = to string! 1.1.1
	--test-- "to-string!-paren!-1"		--assert "" = to string! first [()]
	--test-- "to-string!-paren!-2"		--assert "12" = to string! first [(1 2)]
	--test-- "to-string!-tag!"		--assert "a" = to string! <a>
	--test-- "to-string!-time!"		--assert "10:00:00" = to string! 10:00
	--test-- "to-string!-date!"		
		--assert equal? "16-Jun-2014/14:34:59+02:00"
						to string! 16-Jun-2014/14:34:59+2:00
	--test-- "to-string!-email!"		--assert "foo@boo" = to string! foo@boo
	--test-- "to-string!-bitset!"		--assert "make bitset! #{00}" = to string! make bitset! #{00}
	
===end-group===

===start-group=== "to-integer!"

	--test-- "to-integer!-char!"		--assert 97 = to integer! #"a"
	--test-- "to-integer!-integer!-1"	--assert 123 = to integer! 123
	--test-- "to-integer!-integer!-2"	--assert 256 = to integer! 256
	--test-- "to-integer!-float!-1"		--assert 1 = to integer! 1.5
	--test-- "to-integer!-integer!-3"	--assert -1 = to integer! -1
	--test-- "to-integer!-float!-2"		--assert -1 = to integer! -1.5
	--test-- "to-integer!-issue!"		--assert 65280 = to integer! #FF00
	--test-- "to-integer!-binary!"		--assert 0 = to integer! #{}
	--test-- "to-integer!-binary!"		--assert 6382179 = to integer! #{616263}
	--test-- "to-integer!-time!"		--assert 36000 = to integer! 10:00
	--test-- "to-integer!-1"		--assert 1 == to integer! "1" 
	--test-- "to-integer!-2"		--assert error? try [to integer! "1.0"]
	--test-- "to-integer!-2-1"		--assert error? try [to integer! "1e2"]
	--test-- "to-integer!-2-2"		--assert error? try [to integer! "1 foo"]
	--test-- "to-integer!-3"		--assert 1 == to integer! #"^(01)" 
	--test-- "to-integer!-4"		--assert 49 == to integer! #"1"		
 	--test-- "to-integer!-5"		--assert 128512 == to integer! #"😀"
	--test-- "to-integer!-6"		--assert error? try [to integer! "😀"]	
	--test-- "to-integer!-7"		--assert error? try [to integer! "a"]
	--test-- "to-integer!-8"		--assert 1 == to integer! 1.00
	--test-- "to-integer!-9"		--assert 1 == to integer! 1.999999999999999
	--test-- "to-integer!-10"		--assert -1 == to integer! -1.9999999999
	--test-- "to-integer!-11"		--assert 2147483647 == to integer! "2147483647"
	--test-- "to-integer!-12"		--assert error? try [to integer! 2147483647.1]
	--test-- "to-integer!-13"		--assert 2147483646 == to integer! 2147483646.999999
	--test-- "to-integer!-14"		--assert 2147483647 == to integer! 2147483646.9999999
	--test-- "to-integer!-15"		--assert -2147483648 == to integer! "-2147483648"
	--test-- "to-integer!-16"		--assert error? try [to integer! -2147483648.1]
	--test-- "to-integer!-17"		--assert -2147483647 == to integer! -2147483647.999999
	--test-- "to-integer!-18"		--assert -2147483648 == to integer! -2147483647.9999999
	--test-- "to-integer!-19"		--assert 2 == to integer! 1.9999999999999999
	--test-- "to-integer!-20"		--assert 34200 == to integer! 09:30
	--test-- "to-integer!-21"		--assert 32400 == to integer! 09:00
	--test-- "to-integer!-22"		--assert 86399 == to integer! 23:59:59
	--test-- "to-integer!-23"		--assert 86400 == to integer! 23:59:59.999999
	--test-- "to-integer!-24"		--assert 0 == to integer! #{}
	--test-- "to-integer!-25"		--assert 255 == to integer! #{FF}
	--test-- "to-integer!-26"		--assert -559038737 == to integer! #{DEADBEEF BADCAFEE}
	--test-- "to-integer!-27"							;-- #4325
		--assert 0 == to integer! next #{}
		--assert 255 == to integer! next #{00FF}
		--assert -559038737 == to integer! skip #{BADCAFEE DEADBEEF} 4
	
	--test-- "to-integer!-28"		--assert 15 = to 0 #f
	--test-- "to-integer!-29"		--assert 4095 = to 0 #fff
	--test-- "to-integer!-30"		--assert 1048575 = to 0 #fffff
	--test-- "to-integer!-31"		--assert 305419896 = to 0 #12345678
	--test-- "to-integer!-32"		--assert error? try [to 0 #123456789]
	--test-- "to-integer!-33"		--assert error? try [to 0 #1234567890]

===end-group===

===start-group=== "to-float!"

	--test-- "to-float!-char!"		--assert 97.0 = to float! #"a"
	--test-- "to-float!-integer!"		--assert 123.0 = to float! 123
	--test-- "to-float!-integer!"		--assert 256.0 = to float! 256
	--test-- "to-float!-float!"		--assert 1.5 = to float! 1.5
	--test-- "to-float!-integer!"		--assert -1.0 = to float! -1
	--test-- "to-float!-float!"		--assert -1.5 = to float! -1.5
	--test-- "to-float!-binary!"		--assert 0.0 = to float! #{}
	--test-- "to-float!-binary!"		--assert 3.1532154e-317 = to float! #{616263}
	--test-- "to-float!-block!"		--assert 100.0 = to float! [1 2]
	--test-- "to-float!-paren!"		--assert 100.0 = to float! first [(1 2)]
	--test-- "to-float!-time!"		--assert 36000.0 = to float! 10:00
	--test-- "to-float!-1"			--assert 1.0 == to float! 1
	--test-- "to-float!-2"			--assert 1.0 == to float! "1"
	--test-- "to-float!-3"			--assert 1.0 == to float! #"^(01)"
	--test-- "to-float!-4"			--assert 49.0 == to float! #"1"
	--test-- "to-float!-5"			--assert 2147483648.0 == to float! "2147483648"
	--test-- "to-float!-6"			--assert -2147483649.0 == to float! "-2147483649"
	--test-- "to-float!-7"			--assert 4.0 == to float! first 4x4
	--test-- "to-float!-8"			
		--assert all [
			float! == type? to float! 09:30
			34200.0 = to float! 09:30
		]
	--test-- "to-float!-9"
		--assert all [
			float! == type? to float! 09:00
			32400.0 = to float! 09:00
		]
	--test-- "to-float!-10"	
		--assert all [
			float! == type? to float! 23:59:59.999999
			86399.999999 = to float! 23:59:59.999999
		]
	
===end-group===

===start-group=== "to-percent!"

	--test-- "to-percent-1" --assert 100%   = to percent! "100%"
	--test-- "to-percent-2" --assert 10000% = to percent! "100"
	--test-- "to-percent-3" --assert 10000% = to percent! "100.0"
	--test-- "to-percent-4" --assert 100%   = to percent! "1.0"
	--test-- "to-percent-5" --assert 10%    = to percent! "0.1"
	--test-- "to-percent-6" --assert 1%     = to percent! "0.01"

===end-group===

===start-group=== "implicit to float!"

	--test-- "implicit-to-float!-1"		--assert 2147483648.0 == 2147483648
	--test-- "implicit-to-float!-2"		--assert -2147483649.0 == -2147483649

===end-group===

===start-group=== "to-pair!"

	--test-- "to-pair!-integer!"		--assert 123x123 = to pair! 123
	--test-- "to-pair!-integer!"		--assert 256x256 = to pair! 256
	--test-- "to-pair!-integer!"		--assert -1x-1 = to pair! -1
	--test-- "to-pair!-pair!"		--assert 1x2 = to pair! 1x2
	--test-- "to-pair!-block!"		--assert 1x2 = to pair! [1 2]

===end-group===

===start-group=== "to-word!"
	--test-- "to-word!-char!"		--assert 'a = to word! #"a"
	--test-- "to-word!-string!"		--assert 'foo = to word! "foo"
	--test-- "to-word!-word!"		--assert 'word = to word! 'word
	--test-- "to-word!-refinement!"		--assert 'refinement = to word! /refinement
	--test-- "to-word!-issue!"		--assert 'FF00 = to word! #FF00
	;; #2619
	--test-- "to-word-1"			--assert error? try [to word! to issue! #"1"]
===end-group===
===start-group=== "to-refinement!"
	--test-- "to-refinement!-char!"
		--assert refinement? to refinement! #"a"
		--assert "/a" = mold to refinement! #"a"
	--test-- "to-refinement!-string!"
		--assert refinement? to refinement! "foo"
		--assert "/foo" = mold to refinement! "foo"
	--test-- "to-refinement!-word!"
		--assert refinement? to refinement! 'word
		--assert "/word" = mold to refinement! 'word
	--test-- "to-refinement!-refinement!"
		--assert refinement? to refinement! /refinement
		--assert "/refinement" = mold to refinement! /refinement
	--test-- "to-refinement!-issue!"
		--assert /FF00 = to refinement! #FF00
===end-group===
===start-group=== "to-path!"
	--test-- "to-path!-char!"
		--assert path? to path! #"a"
		--assert {#"a"} = mold to path! #"a"
	--test-- "to-path!-string!"
		--assert path? to path! "foo"
		--assert "foo" = form to path! "foo"
	--test-- "to-path!-integer!"
		--assert path? to path! 123
		--assert "123" = form to path! 123
	--test-- "to-path!-integer!"
		--assert path? to path! 256
		--assert "256" = form to path! 256
	--test-- "to-path!-float!"
		--assert path? to path! 1.5
		--assert "1.5" = form to path! 1.5
	--test-- "to-path!-integer!"
		--assert path? to path! -1
		--assert "-1" = form to path! -1
	--test-- "to-path!-float!"
		--assert path? to path! -1.5
		--assert "-1.5" = form to path! -1.5
	--test-- "to-path!-pair!"
		   --assert path? to path! 1x2
		   --assert "1x2" = form to path! 1x2
	--test-- "to-path!-word!"
		--assert path? to path! 'word
		--assert "word" = form to path! 'word
	--test-- "to-path!-refinement!"
		--assert path? to path! /refinement
		--assert "/refinement" = mold to path! /refinement
	--test-- "to-path!-path!"
		--assert path? to path! 'path/foo
		--assert "path/foo" = mold to path! 'path/foo
	--test-- "to-path!-url!"
		--assert path? to path! http://red-lang.org
		--assert http://red-lang.org = first to path! http://red-lang.org
	--test-- "to-path!-file!"
		--assert path? to path! %/file/
		--assert "%/file/" = mold to path! %/file/
	--test-- "to-path!-issue!"
		--assert path? to path! #FF00
		--assert "#FF00" = mold to path! #FF00
	--test-- "to-path!-binary!"
		--assert path? to path! #{}
		--assert "#{}" = mold to path! #{}
	--test-- "to-path!-binary!"
		--assert path? to path! #{616263}
		--assert "#{616263}" = mold to path! #{616263}
	--test-- "to-path!-block!"
		--assert path? to path! []
		--assert "" = mold to path! []
	--test-- "to-path!-block!"
		--assert path? to path! [1 2]
		--assert "1/2" = form to path! [1 2]
	--test-- "to-path!-block!"
		--assert path? to path! [1 2 3]
		--assert "1/2/3" = form to path! [1 2 3]
	--test-- "to-path!-block!"
		--assert path? to path! ["a" "b"]
		--assert {"a"/"b"} = mold to path! ["a" "b"]
	--test-- "to-path!-tuple!"
		   --assert path? to path! 1.1.1
		   --assert "1.1.1" = form to path! 1.1.1
	--test-- "to-path!-paren!"
		--assert path? to path! first [()]
	--test-- "to-path!-paren!"
		--assert path? to path! first [(1 2)]
		--assert "1/2" = form to path! first [(1 2)]
	--test-- "to-path!-tag!"
		--assert path? to path! <a>
		--assert <a> = first to path! <a>
	--test-- "to-path!-time!"
		--assert path? to path! 10:00
		--assert 10:00 = first to path! 10:00
	--test-- "to-path!-date!"
		   --assert path? to path! 16-Jun-2014/14:34:59+2:00
		   --assert "16-Jun-2014/14:34:59+02:00" = form to path! 16-Jun-2014/14:34:59+2:00
	--test-- "to-path!-email!"
		--assert path? to path! foo@boo
		--assert foo@boo = first to path! foo@boo
	--test-- "to-path!-bitset!"
		--assert path? to path! make bitset! #{00}
		--assert "make bitset! #{00}" = form to path! make bitset! #{00}
===end-group===
===start-group=== "to-url!"
	--test-- "to-url!-char!"
		--assert url? to url! #"a"
		--assert "a" = form to url! #"a"
	--test-- "to-url!-string!"
		--assert url? to url! "foo"
		--assert "foo" = form to url! "foo"
	--test-- "to-url!-integer!"
		--assert url? to url! 123
		--assert "123" = form to url! 123
	--test-- "to-url!-integer!"
		--assert url? to url! 256
		--assert "256" = form to url! 256
	--test-- "to-url!-float!"
		--assert url? to url! 1.5
		--assert "1.5" = form to url! 1.5
	--test-- "to-url!-integer!"
		--assert url? to url! -1
		--assert "-1" = form to url! -1
	--test-- "to-url!-float!"
		--assert url? to url! -1.5
		--assert "-1.5" = form to url! -1.5
	--test-- "to-url!-pair!"
		--assert url? to url! 1x2
		--assert "1x2" = form to url! 1x2
	--test-- "to-url!-word!"
		--assert url? to url! 'word
		--assert "word" = form to url! 'word
	--test-- "to-url!-refinement!"
		--assert url? to url! /refinement
		--assert "/refinement" = form to url! /refinement
	--test-- "to-url!-path!"
		--assert url? to url! 'path/foo
		--assert "path/foo" = form to url! 'path/foo
	--test-- "to-url!-url!"
		--assert url? to url! http://red-lang.org
		--assert "http://red-lang.org" = form to url! http://red-lang.org
	--test-- "to-url!-file!"
		--assert url? to url! %/file/
		--assert "/file/" = form to url! %/file/
	--test-- "to-url!-issue!"
		--assert url? to url! #FF00
		--assert "FF00" = form to url! #FF00
	--test-- "to-url!-binary!"
		   --assert url? to url! #{}
		   --assert "" = form to url! #{}
	--test-- "to-url!-binary!"
		--assert url? to url! #{616263}
		--assert "abc" = form to url! #{616263}
	--test-- "to-url!-block!"
		--assert http:// 				= to-url [http]
		--assert http://domain 				= to-url [http domain]
		--assert http://domain.com 			= to-url [http domain.com]
		--assert http://domain.com:8080 		= to-url [http domain.com 8080]
		--assert http://domain.com:43/path 		= to-url [http domain.com 43 path]
		--assert http://domain.com/path 		= to-url [http domain.com path]
		--assert http://domain.com/file.red 		= to-url [http domain.com file.red]
		--assert http://domain.com/path/file 		= to-url [http domain.com path file]
		--assert http://domain.com/path/file#anchor 	= to-url [http domain.com path file #anchor]
		--assert http://domain.com/path/file.red 	= to-url [http domain.com path file.red]
	--test-- "to-url!-tuple!"
		--assert url? to url! 1.1.1
		--assert "1.1.1" = form to url! 1.1.1
	--test-- "to-url!-paren!"
	   --assert error? try [to url! first [()]]
	--test-- "to-url!-paren!"
		--assert url? to url! first [(1 2)]
		--assert "1://2" = form to url! first [(1 2)]
	--test-- "to-url!-tag!"
		--assert url? to url! <a>
		--assert "a" = form to url! <a>
	--test-- "to-url!-time!"
		--assert url? to url! 10:00
		--assert "10:00:00" = form to url! 10:00
	--test-- "to-url!-date!"
	   --assert url? to url! 16-Jun-2014/14:34:59+2:00
	   --assert "16-Jun-2014/14:34:59+02:00" = form to url! 16-Jun-2014/14:34:59+2:00
	--test-- "to-url!-email!"
		--assert url? to url! foo@boo
		--assert "foo@boo" = form to url! foo@boo
	--test-- "to-url!-bitset!"
		--assert url? to url! make bitset! #{00}
		--assert "make bitset! #{00}" = form to url! make bitset! #{00}
===end-group===
===start-group=== "to-file!"
	--test-- "to-file!-char!"
		--assert %a = to file! #"a"
	--test-- "to-file!-string!"
		--assert %foo = to file! "foo"
	--test-- "to-file!-integer!"
		--assert %123 = to file! 123
	--test-- "to-file!-integer!"
		--assert %256 = to file! 256
	--test-- "to-file!-float!"
		--assert %1.5 = to file! 1.5
	--test-- "to-file!-integer!"
		--assert %-1 = to file! -1
	--test-- "to-file!-float!"
		--assert %-1.5 = to file! -1.5
	--test-- "to-file!-pair!"
		--assert %1x2 = to file! 1x2
	--test-- "to-file!-word!"
		--assert %word = to file! 'word
	--test-- "to-file!-refinement!"
		--assert %/refinement = to file! /refinement
	--test-- "to-file!-path!"
		--assert %path/foo = to file! 'path/foo
	--test-- "to-file!-url!"
		--assert "http://red-lang.org" = form to file! http://red-lang.org
	--test-- "to-file!-file!"
		--assert %/file/ = to file! %/file/
	--test-- "to-file!-issue!"
		--assert %FF00 = to file! #FF00
	--test-- "to-file!-binary!"
		--assert %"" = to file! #{}
	--test-- "to-file!-binary!"
		--assert %abc = to file! #{616263}
	--test-- "to-file!-block!"
		--assert %"" = to file! []
	--test-- "to-file!-block!"
		--assert %12 = to file! [1 2]
	--test-- "to-file!-block!"
		--assert %123 = to file! [1 2 3]
	--test-- "to-file!-block!"
		--assert %ab = to file! ["a" "b"]
	--test-- "to-file!-tuple!"
		--assert %1.1.1 = to file! 1.1.1
	--test-- "to-file!-paren!"
		--assert %"" = to file! first [()]
	--test-- "to-file!-paren!"
		--assert %12 = to file! first [(1 2)]
	--test-- "to-file!-tag!"
		--assert %a = to file! <a>
	--test-- "to-file!-time!"
		--assert "10:00:00" = form to file! 10:00
	--test-- "to-file!-date!"
		--assert %"16-Jun-2014/14:34:59+02:00" = to file! 16-Jun-2014/14:34:59+2:00
	--test-- "to-file!-email!"
		--assert "foo@boo" = form to file! foo@boo
	--test-- "to-file!-bitset!"
		--assert %make%20bitset!%20#%7B00%7D = to file! make bitset! #{00}
===end-group===
===start-group=== "to-issue!"
	--test-- "to-issue!-char!"			--assert #a = to issue! #"a"
	--test-- "to-issue!-string!"			--assert #foo = to issue! "foo"
	--test-- "to-issue!-word!"			--assert #word = to issue! 'word
	--test-- "to-issue!-refinement!"		--assert #refinement = to issue! /refinement
	--test-- "to-issue!-issue!"			--assert #FF00 = to issue! #FF00
	--test-- "to-issue!-1"				--assert #1 = to issue! #"1"
	;; #2619
	--test-- "to-issue!-2"				--assert #1 = to issue! "1"
	--test-- "to-issue!-3"				--assert error? try [ to issue! 1 ]
	--test-- "to-issue!-4"				--assert #1-big-issue = to issue! "1-big-issue" 
		
===end-group===
===start-group=== "to-binary!"
	--test-- "to-binary!-char!"
		--assert #{61} = to binary! #"a"
	--test-- "to-binary!-string!"
		--assert #{666F6F} = to binary! "foo"
	--test-- "to-binary!-integer!"
		--assert #{0000007B} = to binary! 123
	--test-- "to-binary!-integer!"
		--assert #{00000100} = to binary! 256
	--test-- "to-binary!-float!"
		--assert #{3FF8000000000000} = to binary! 1.5
	--test-- "to-binary!-integer!"
		--assert #{FFFFFFFF} = to binary! -1
	--test-- "to-binary!-float!"
		--assert #{BFF8000000000000} = to binary! -1.5
	--test-- "to-binary!-url!"
		--assert #{687474703A2F2F7265642D6C616E672E6F7267} = to binary! http://red-lang.org
	--test-- "to-binary!-file!"
		--assert #{2F66696C652F} = to binary! %/file/
	--test-- "to-binary!-binary!"
		--assert #{} = to binary! #{}
	--test-- "to-binary!-binary!"
		--assert #{616263} = to binary! #{616263}
	--test-- "to-binary!-block!"
		--assert #{} = to binary! []
	--test-- "to-binary!-block!"
		--assert #{0102} = to binary! [1 2]
	--test-- "to-binary!-block!"
		--assert #{010203} = to binary! [1 2 3]
	--test-- "to-binary!-block!"
		--assert #{6162} = to binary! ["a" "b"]
    --test-- "to-binary!-tuple!"
		--assert #{010101} = to binary! 1.1.1
	--test-- "to-binary!-tag!"
		--assert #{61} = to binary! <a>
	--test-- "to-binary!-email!"
		--assert #{666F6F40626F6F} = to binary! foo@boo
	--test-- "to-binary!-bitset!"
		--assert #{00} = to binary! make bitset! #{00}
	--test-- "issue #3636"
		--assert 97 = pick to binary! append/dup a: "" "a" 1100000 1
	--test-- "issue #4272"
		--assert #{DEADBEEF} = to binary! quote (222 173 190 239)
		--assert #{BADCAFEE} = to binary! make hash! [186 220 175 238]
===end-group===
===start-group=== "to-block!"
	--test-- "to-block!-char!"
		--assert [#"a"] = to block! #"a"
	--test-- "to-block!-string!"
		--assert [foo] = to block! "foo"
	--test-- "to-block!-integer!"
		--assert [123] = to block! 123
	--test-- "to-block!-integer!"
		--assert [256] = to block! 256
	--test-- "to-block!-float!"
		--assert [1.5] = to block! 1.5
	--test-- "to-block!-integer!"
		--assert [-1] = to block! -1
	--test-- "to-block!-float!"
		--assert [-1.5] = to block! -1.5
	--test-- "to-block!-pair!"
		--assert [1x2] = to block! 1x2
	--test-- "to-block!-word!"
		--assert [word] = to block! 'word
	--test-- "to-block!-refinement!"
		--assert [/refinement] = to block! /refinement
	--test-- "to-block!-path!"
		--assert [path foo] = to block! 'path/foo
	--test-- "to-block!-url!"
		--assert [http://red-lang.org] = to block! http://red-lang.org
	--test-- "to-block!-file!"
		--assert [%/file/] = to block! %/file/
	--test-- "to-block!-issue!"
		--assert [#FF00] = to block! #FF00
	--test-- "to-block!-binary!"
		--assert [#{}] = to block! #{}
	--test-- "to-block!-binary!"
		--assert [#{616263}] = to block! #{616263}
	--test-- "to-block!-block!"
		--assert [] = to block! []
	--test-- "to-block!-block!"
		--assert [1 2] = to block! [1 2]
	--test-- "to-block!-block!"
		--assert [1 2 3] = to block! [1 2 3]
	--test-- "to-block!-block!"
		--assert ["a" "b"] = to block! ["a" "b"]
	--test-- "to-block!-tuple!"
		--assert [1.1.1] = to block! 1.1.1
	--test-- "to-block!-paren!"
		--assert [] = to block! first [()]
	--test-- "to-block!-paren!"
		--assert [1 2] = to block! first [(1 2)]
	--test-- "to-block!-tag!"
		--assert [<a>] = to block! <a>
	--test-- "to-block!-time!"
		--assert [10:00] = to block! 10:00
	--test-- "to-block!-date!"
		--assert [16-Jun-2014/14:34:59+2:00] = to block! 16-Jun-2014/14:34:59+2:00
	--test-- "to-block!-email!"
		--assert [foo@boo] = to block! foo@boo
	--test-- "to-block!-bitset!"
		--assert (reduce [make bitset! #{00}]) = to block! make bitset! #{00}
===end-group===
===start-group=== "to-tuple!"
	--test-- "to-tuple!-issue!"
		--assert 255.0.0 = to tuple! #FF0000
		--assert 255.255.255 = to tuple! #fff
		--assert error? try [to tuple! #f]
		--assert error? try [to tuple! #ff]
		--assert error? try [to tuple! #ffff]

	--test-- "to-tuple!-binary!"
		--assert 0.0.0 = to tuple! #{}
	--test-- "to-tuple!-binary!"
		--assert 97.98.99 = to tuple! #{616263}
	--test-- "to-tuple!-block!"
		--assert 0.0.0 = to tuple! []
	--test-- "to-tuple!-block!"
		--assert 1.2.0 = to tuple! [1 2]
	--test-- "to-tuple!-block!"
		--assert 1.2.3 = to tuple! [1 2 3]
	--test-- "to-tuple!-tuple!"
		--assert 1.1.1 = to tuple! 1.1.1
	--test-- "to-tuple!-paren!"
		--assert 0.0.0 = to tuple! first [()]
	--test-- "to-tuple!-paren!"
		--assert 1.2.0 = to tuple! first [(1 2)]
===end-group===
===start-group=== "to-paren!"
	--test-- "to-paren!-char!"
		--assert (first [(#"a")]) = to paren! #"a"
	--test-- "to-paren!-string!"
		--assert (first [('foo)]) = to paren! "foo"
	--test-- "to-paren!-integer!"
		--assert (first [(123)]) = to paren! 123
	--test-- "to-paren!-integer!"
		--assert (first [(256)]) = to paren! 256
	--test-- "to-paren!-float!"
		--assert (first [(1.5)]) = to paren! 1.5
	--test-- "to-paren!-integer!"
		--assert (first [(-1)]) = to paren! -1
	--test-- "to-paren!-float!"
		--assert (first [(-1.5)]) = to paren! -1.5
	--test-- "to-paren!-pair!"
		--assert (first [(1x2)]) = to paren! 1x2
	--test-- "to-paren!-word!"
		--assert (first [('word)]) = to paren! 'word
	--test-- "to-paren!-refinement!"
		--assert (first [(/refinement)]) = to paren! /refinement
	--test-- "to-paren!-path!"
		--assert (first [('path 'foo)]) = to paren! 'path/foo
	--test-- "to-paren!-url!"
		--assert (first [(http://red-lang.org)]) = to paren! http://red-lang.org
	--test-- "to-paren!-file!"
		--assert (first [(%/file/)]) = to paren! %/file/
	--test-- "to-paren!-issue!"
		--assert (first [(#FF00)]) = to paren! #FF00
	--test-- "to-paren!-binary!"
		--assert (first [(#{})]) = to paren! #{}
	--test-- "to-paren!-binary!"
		--assert (first [(#{616263})]) = to paren! #{616263}
	--test-- "to-paren!-block!"
		--assert (first [()]) = to paren! []
	--test-- "to-paren!-block!"
		--assert (first [(1 2)]) = to paren! [1 2]
	--test-- "to-paren!-block!"
		--assert (first [(1 2 3)]) = to paren! [1 2 3]
	--test-- "to-paren!-block!"
		--assert (first [("a" "b")]) = to paren! ["a" "b"]
	--test-- "to-paren!-tuple!"
		--assert (first [(1.1.1)]) = to paren! 1.1.1
	--test-- "to-paren!-paren!"
		--assert (first [()]) = to paren! first [()]
	--test-- "to-paren!-paren!"
		--assert (first [(1 2)]) = to paren! first [(1 2)]
	--test-- "to-paren!-tag!"
		--assert (first [(<a>)]) = to paren! <a>
	--test-- "to-paren!-time!"
		--assert (first [(10:00)]) = to paren! 10:00
	--test-- "to-paren!-date!"
		--assert (first [(16-Jun-2014/14:34:59+2:00)]) = to paren! 16-Jun-2014/14:34:59+2:00
	--test-- "to-paren!-email!"
		--assert (first [(foo@boo)]) = to paren! foo@boo
	--test-- "to-paren!-bitset!"
		append p: make paren! 1 make bitset! #{00}
		--assert p = to paren! make bitset! #{00}
===end-group===
===start-group=== "to-tag!"
	--test-- "to-tag!-char!"
		--assert <a> = to tag! #"a"
	--test-- "to-tag!-string!"
		--assert <foo> = to tag! "foo"
	--test-- "to-tag!-integer!"
		--assert <123> = to tag! 123
	--test-- "to-tag!-integer!"
		--assert <256> = to tag! 256
	--test-- "to-tag!-float!"
		--assert <1.5> = to tag! 1.5
	--test-- "to-tag!-integer!"
		--assert <-1> = to tag! -1
	--test-- "to-tag!-float!"
		--assert <-1.5> = to tag! -1.5
	--test-- "to-tag!-pair!"
		--assert <1x2> = to tag! 1x2
	--test-- "to-tag!-word!"
		--assert <word> = to tag! 'word
	--test-- "to-tag!-refinement!"
		--assert </refinement> = to tag! /refinement
	--test-- "to-tag!-path!"
		--assert <path/foo> = to tag! 'path/foo
	--test-- "to-tag!-url!"
		--assert <http://red-lang.org> = to tag! http://red-lang.org
	--test-- "to-tag!-file!"
		--assert </file/> = to tag! %/file/
	--test-- "to-tag!-issue!"
		--assert <FF00> = to tag! #FF00
	--test-- "to-tag!-binary!"
		--assert (clear <o>) = to tag! #{}
	--test-- "to-tag!-binary!"
		--assert <abc> = to tag! #{616263}
	--test-- "to-tag!-block!"
		--assert (clear <o>) = to tag! []
	--test-- "to-tag!-block!"
		--assert <12> = to tag! [1 2]
	--test-- "to-tag!-block!"
		--assert <123> = to tag! [1 2 3]
	--test-- "to-tag!-block!"
		--assert <ab> = to tag! ["a" "b"]
	--test-- "to-tag!-tuple!"
		--assert <1.1.1> = to tag! 1.1.1
	--test-- "to-tag!-paren!"
		--assert (clear <o>) = to tag! first [()]
	--test-- "to-tag!-paren!"
		--assert <12> = to tag! first [(1 2)]
	--test-- "to-tag!-tag!"
		--assert <a> = to tag! <a>
	--test-- "to-tag!-date!"
		--assert <16-Jun-2014/14:34:59+02:00> = to tag! 16-Jun-2014/14:34:59+2:00
	--test-- "to-tag!-email!"
		--assert <foo@boo> = to tag! foo@boo
	--test-- "to-tag!-bitset!"
		--assert <make bitset! #{00}> = to tag! make bitset! #{00}
===end-group===
===start-group=== "to-time!"
	--test-- "to-time!-integer!"
		--assert 0:02:03 = to time! 123
	--test-- "to-time!-integer!"
		--assert 0:04:16 = to time! 256
	--test-- "to-time!-float!"
		--assert 0:00:01.5 = to time! 1.5
	--test-- "to-time!-integer!"
		--assert -0:00:01 = to time! -1
	--test-- "to-time!-float!"
		--assert -0:00:01.5 = to time! -1.5
	--test-- "to-time!-block!"
		--assert 1:02 = to time! [1 2]
	--test-- "to-time!-block!"
		--assert 1:02:03 = to time! [1 2 3]
	--test-- "to-time!-paren!"
		--assert 1:02 = to time! first [(1 2)]
	--test-- "to-time!-time!"
		--assert 10:00 = to time! 10:00
===end-group===
===start-group=== "to-date!"
	--test-- "to-date!-block!"
		--assert 1-Feb-0003 = to date! [1 2 3]
	--test-- "to-date!-date!"
		--assert 16-Jun-2014/14:34:59+2:00 = to date! 16-Jun-2014/14:34:59+2:00
===end-group===
===start-group=== "to-email!"
	--test-- "to-email!-char!"
		--assert equal? head remove next a@ 
						to email! #"a"
	--test-- "to-email!-string!"
		--assert equal? head remove skip foo@ 3
						to email! "foo"
	--test-- "to-email!-integer!-1"
		--assert equal? head remove back tail 123@
						to email! 123
	--test-- "to-email!-integer!-2"
		--assert equal? head remove back tail 256@
						to email! 256
	--test-- "to-email!-float!"
		--assert equal? head remove back tail 1.5@
						to email! 1.5
	--test-- "to-email!-integer!-3"
		--assert equal? head remove back tail -1@
						to email! -1
	--test-- "to-email!-float!-2"
		--assert equal? head remove back tail -1.5@
						to email! -1.5
	--test-- "to-email!-pair!"
		--assert equal? head remove back tail 1x2@
						to email! 1x2
	--test-- "to-email!-word!"
		--assert equal? head remove back tail word@ 
						to email! 'word
	;--test-- "to-email!-refinement!"
	;	--assert equal? head remove back tail /refinement@
	;					to email! /refinement
	;--test-- "to-email!-path!"
	;	--assert equal? head remove back tail path/foo@ 
	;					to email! first [path/foo]
	;--test-- "to-email!-url!"
	;	--assert equal? head remove back tail http://red-lang.org@ 
	;					to email! http://red-lang.org
	--test-- "to-email!-file!"
		tef-email: append %/file/ #"@"
		--assert equal? head remove back tail tef-email
						to email! %/file/
	--test-- "to-email!-issue!"
		--assert equal? head remove back tail "FF00@"
						to email! #FF00
	--test-- "to-email!-binary!-1"
		--assert 0 = length? to email! #{}
	--test-- "to-email!-binary!-2"
		teb2-mail: load append #{616263} #"@"
		--assert equal? head remove back tail teb2-mail
						to email! #{616263}
	--test-- "to-email!-block!-1"
		--assert 0 = length? to email! []
	--test-- "to-email!-block!-2"
		--assert equal? head remove back tail 12@
						to email! [1 2]
	--test-- "to-email!-block!-3"
		--assert equal? head remove back tail 123@
						to email! [1 2 3]
	--test-- "to-email!-block!-4"
		--assert equal? head remove back tail ab@
						to email! ["a" "b"]
	--test-- "to-email!-block-5"
		--assert equal? testing@red-lang.org 
						to email! [testing #"@" red-lang.org]
	--test-- "to-email!-tuple!"
		--assert equal? to email! "1.1.1" to email! 1.1.1
	--test-- "to-email!-paren!-1"
		--assert 0 = length? to email! first [()]
	--test-- "to-email!-paren!"
		--assert equal? head remove back tail 12@
						to email! first [(1 2)]
	--test-- "to-email!-tag!"
		--assert equal? head remove back tail a@
						to email! <a>
	--test-- "to-email!-time!"
		--assert equal? to email! "10:00:00"
						to email! 10:00
	--test-- "to-email!-date!"
   		--assert equal? to email! "16-Jun-2014/14:34:59+02:00"
   						to email! 16-Jun-2014/14:34:59+2:00
   	--test-- "to-email!-email!"
   		--assert equal? foo@boo to email! foo@boo
   	;--test-- "to-email!-bitset!"
   	;	--assert equal? head remove back tail make%20bitset!%20%23%7B00%7D@
   	;					to email! make bitset! #{00}
===end-group===
===start-group=== "to-bitset!"
	--test-- "to-bitset!-char!"
		--assert (make bitset! #{00000000000000000000000040}) = to bitset! #"a"
	--test-- "to-bitset!-string!"
		--assert (make bitset! #{0000000000000000000000000201}) = to bitset! "foo"
	--test-- "to-bitset!-integer!"
		--assert error? try [ to bitset! 123 ]
	--test-- "to-bitset!-integer!"
		--assert error? try [ to bitset! 256 ]
	--test-- "to-bitset!-url!"
		--assert error? try [ to bitset! http://red-lang.org ]
	--test-- "to-bitset!-file!"
		--assert error? try [ to bitset! %/file/ ]
	--test-- "to-bitset!-binary!"
		--assert (make bitset! #{}) = to bitset! #{}
	--test-- "to-bitset!-binary!"
		--assert (make bitset! #{616263}) = to bitset! #{616263}
	--test-- "to-bitset!-block!"
		--assert (make bitset! #{00}) = to bitset! []
	--test-- "to-bitset!-block!"
		--assert (make bitset! #{60}) = to bitset! [1 2]
	--test-- "to-bitset!-block!"
		--assert (make bitset! #{70}) = to bitset! [1 2 3]
	--test-- "to-bitset!-block!"
		--assert (make bitset! #{00000000000000000000000060}) = to bitset! ["a" "b"]
	--test-- "to-bitset!-tag!"
		--assert error? try [ to bitset! <a> ]
	--test-- "to-bitset!-email!"
		--assert error? try [ to bitset! foo@boo ]
===end-group===


~~~end-file~~~
