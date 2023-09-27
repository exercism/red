Red [
	Title:   "Red case folding test script"
	Author:  "Peter W A Wood"
	File: 	 %case-folding-test.red
	Tabs:	 4
	Rights:  "Copyright (C) 2011-2015 Red Foundation. All rights reserved."
	License: "BSD-3 - https://github.com/red/red/blob/origin/BSD-3-License.txt"
]

#include  %../../../quick-test/quick-test.red

~~~start-file~~~ "case-folding"

do-test-number: 0
dont-test-number: 0

do-fold: func [lower upper] [
	do-test-number: do-test-number + 1
	--test-- append copy "case-folding-" do-test-number
		--assert lower = upper
		--assert equal? lower upper
		--assert strict-equal? uppercase copy lower upper
		--assert upper == uppercase copy lower
		--assert strict-equal? lower lowercase copy upper
		--assert lower == lowercase copy upper
]

dont-fold: func [lower upper] [
	dont-test-number: dont-test-number + 1
	--test-- append copy "not-case-folding-" dont-test-number
		--assert lower <> upper
		--assert not equal? lower upper
		--assert not equal? uppercase copy lower upper
		--assert upper <> uppercase copy lower
		--assert not equal? lower lowercase copy upper
		--assert lower <> lowercase copy upper
]

===start-group=== "case-folding"
	
	do-fold "abcde" "ABCDE"
	do-fold "cant^(F9)" "CANT^(D9)"
	do-fold "cantu^(0300)" "CANTU^(0300)"
	do-fold "i" "I"
	do-fold "^(2173)" "^(2163)"
	do-fold "^(EE)" "^(CE)"
	do-fold "^(0101)" "^(0100)"
	do-fold "^(03B9)" "^(0399)"
	do-fold "^(03C9)" "^(03A9)"
	do-fold "^(13F8)" "^(13F0)"
	do-fold "^(10FF)" "^(1CBF)"
	do-fold "^(026A)" "^(A7AE)"
	do-fold "^(029D)" "^(A7B2)"
	do-fold "^(ABBF)" "^(13EF)"
	do-fold "^(0104D8)" "^(0104B0)"
	do-fold "^(010CF2)" "^(010CB2)"
	do-fold "^(016E60)" "^(016E40)"

===end-group===

===start-group=== "not-case-folding"
	
	dont-fold "ba^(FB04)e" "BAFFLE"
	dont-fold "stra^(DF)e" "STRASSE"
	dont-fold "weiss" "wie^(DF)"
	dont-fold "^(0149)" "^(02BC)^(6E)"
	dont-fold "^(03C5)^(0308)^(0301)" "^(03B0)"
	dont-fold "^(0565)^(0582)" "^(0587)"
	dont-fold "^(1E96)" "^(68)^(0331)"
	dont-fold "^(1F80)" "^(1F00)^(03B9)"
	dont-fold "^(03B1)^(03B9)" "^(1FBC)"
	dont-fold "^(03C9)^(03B9)" "^(1FFC)"

===end-group===

===start-group=== "manual case folding"

	--test-- "manual-case-folding-1"
		--assert "abcde" = "aBCDE"
		--assert equal? "abcde" "aBCDE"
		--assert strict-equal? lowercase "aBCDE" "abcde"
		--assert "abcde" == lowercase "aBCDE"
		
	--test-- "manual-case-folding-2"
		--assert "Abcde" = "ABCDE"
		--assert equal? "Abcde" "ABCDE"
		--assert strict-equal? uppercase "Abcde" "ABCDE"
		--assert "ABCDE" == uppercase "Abcde"
		
	--test-- "manual-case-folding-3"
		--assert "s" = "^(017F)"
		--assert "S" = "^(017F)"
		--assert "s" = "S"
		--assert "S" == uppercase "^(017F)"
		--assert "^(017F)" == lowercase "^(017F)"
		--assert "s" == lowercase "S"
		--assert "S" == uppercase "s"

	--test-- "manual-case-folding-4"
		--assert not not all [#"^(0046)" = uppercase #"^(FB04)" #"^(FB04)" <> lowercase #"^(0046)"]
		--assert not not all [#"^(0053)" = uppercase #"^(00DF)" #"^(00DF)" <> lowercase #"^(0053)"]
		--assert not not all [#"^(00DF)" = lowercase #"^(1E9E)" #"^(1E9E)" <> uppercase #"^(00DF)"]
		--assert not not all [#"^(02BC)" = uppercase #"^(0149)" #"^(0149)" <> lowercase #"^(02BC)"]
		--assert not not all [#"^(03A5)" = uppercase #"^(03B0)" #"^(03B0)" <> lowercase #"^(03A5)"]
		--assert not not all [#"^(0535)" = uppercase #"^(0587)" #"^(0587)" <> lowercase #"^(0535)"]
		--assert not not all [#"^(0048)" = uppercase #"^(1E96)" #"^(1E96)" <> lowercase #"^(0048)"]
		--assert not not all [#"^(1F08)" = uppercase #"^(1F80)" #"^(1F80)" <> lowercase #"^(1F08)"]
		--assert not not all [#"^(1F08)" = uppercase #"^(1F88)" #"^(1F88)" <> lowercase #"^(1F08)"]
		--assert not not all [#"^(0391)" = uppercase #"^(1FB3)" #"^(1FB3)" <> lowercase #"^(0391)"]
		--assert not not all [#"^(1FB3)" = lowercase #"^(1FBC)" #"^(1FBC)" <> uppercase #"^(1FB3)"]
		--assert not not all [#"^(03A9)" = uppercase #"^(1FF3)" #"^(1FF3)" <> lowercase #"^(03A9)"]
		--assert not not all [#"^(1FF3)" = lowercase #"^(1FFC)" #"^(1FFC)" <> uppercase #"^(1FF3)"]
		--assert not not all [#"^(0399)" = uppercase #"^(1FBE)" #"^(1FBE)" <> lowercase #"^(0399)"]
		--assert not not all [#"^(03C9)" = lowercase #"^(2126)" #"^(2126)" <> uppercase #"^(03C9)"]

===end-group===

~~~end-file~~~
