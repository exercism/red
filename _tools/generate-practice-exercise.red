Red [
	description: "Practice exercise generator for Exercism's Red track"
	usage: {
		change "author" value in line 11
		"red generate-practice-exercise.red <exercise-slug>"
	}
	author: "loziniak"
]

; change to your GitHub username
author: "kickass"


slug: system/script/args
slug: trim/with copy slug {"'}			; Linux adds quotes around arguments


either system/platform = 'Windows [
	uuid-cmd: {powershell -Command "[guid]::NewGuid().ToString()"}
	copy-cmd: "xcopy /I /E /H"
][
	uuid-cmd: {uuidgen -r}
	copy-cmd: {cp -r}
]

;     ===========================
print "      GENERATE UUID ..."

uuid: copy ""
call/wait/output uuid-cmd uuid
trim/lines uuid


;     ===========================
print "          PATHS ..."

github-problem-spec: rejoin
	[https://raw.githubusercontent.com/exercism/problem-specifications/main/exercises/ slug]

exercise-path: rejoin [%../exercises/practice/ slug]
call/wait rejoin [copy-cmd " " to-local-file %../_templates/practice-exercise " " to-local-file exercise-path]

rename
	rejoin [exercise-path %/practice-exercise.red]
	solution-file: rejoin [exercise-path %/ slug %.red]

rename
	rejoin [exercise-path %/practice-exercise-test.red]
	test-file: rejoin [exercise-path %/ slug %-test.red]

example-file: rejoin [exercise-path %/.meta/example.red]

tests-toml-file: rejoin [exercise-path %/.meta/tests.toml]

config-file: rejoin [exercise-path %/.meta/config.json]

track-config-file: %../config.json


;     ===========================
print "         METADATA ..."

metadata: read rejoin [github-problem-spec %/metadata.toml]
metadata: replace/all metadata {\"} {^^"}
metadata: load metadata

; convert toml to map assuming simple key/value pairs
metadata: make map! parse metadata [collect any['= | keep skip]]

if none? metadata/title [
	metadata/title: title-case: copy slug

	until [
		change title-case
			uppercase first title-case
		title-case: find/tail title-case "-"
		none? title-case
	]
	replace/all metadata/title "-" " "

	metadata/title: head metadata/title
]


;     ===========================
print "   EXERCISE DESCRIPTION ..."

instructions: read/lines
	rejoin [github-problem-spec %/description.md]

instructions:  copy  skip instructions 2
write/lines/append  rejoin [exercise-path %/.docs/instructions.md]  instructions


;     ===========================
print "       TEST SUITE ..."

canonical-data: either map? canonical-data: try [
	load-json read 
		rejoin [github-problem-spec %/canonical-data.json]
] [
	canonical-data
] [
	#( cases: [])
]

camel-to-kebab-case: function [
	"Converts a string in camelCase to kebab-case"
	camel-case [string!]
	return: [string!]
] [
	kebab-case: copy camel-case

	forall kebab-case [
		if all [
			#"A" <= to-be-lowered: first kebab-case
			#"Z" >= first kebab-case
		] [
			remove kebab-case
			insert kebab-case rejoin ["-" lowercase to-be-lowered]
		]
	]

	kebab-case
]

load-testcases: function [
	testcases [block!]
	return: [block!]
] [
	loaded: copy []
	foreach testcase testcases [
		append loaded
			either none? testcase/cases [
				make map! reduce [
					'description testcase/description
					'input testcase/input
					'expected testcase/expected
					'function camel-to-kebab-case testcase/property
					'uuid testcase/uuid
				]
			] [
				load-testcases testcase/cases				; recurrently load nested testcases
			]
	]
	loaded
]

cases-for-tests: load-testcases canonical-data/cases

test-code: read test-file

test-code: replace/case test-code
	"canonical-cases: []" 
	rejoin [
		"canonical-cases: "
		mold cases-for-tests
		"^/"
	]

test-code: replace/case test-code
	{description: {Tests for "Practie Exercise" Exercism exercise}}
	rejoin ["description: {Tests for ^"" metadata/title "^" Exercism exercise}"]

test-code: replace/case test-code
	"practice-exercise"
	slug

write test-file test-code


;     ===========================
print "      SOLUTION STUB ..."

solution-code: read solution-file

solution-code: replace/case solution-code
	"Practice Exercise"
	metadata/title

functions: copy []
foreach testcase cases-for-tests [
	if all [
		string? testcase/function
		none? find functions testcase/function
	] [
		append functions testcase/function
		arguments: form keys-of testcase/input
		replace/all arguments " " "^/^-"
		if not empty? arguments [
			insert arguments "^/^-"
			append arguments "^/"
		]
		append solution-code rejoin [
			testcase/function
			": function ["
			arguments
			"] [^/^-cause-error 'user 'message ^"You need to implement " testcase/function " function.^"^/]^/^/"
		]
	]
]

example-code: copy solution-code
replace/case example-code
	{author: ""}
	rejoin [{author: "} author {"}]

write example-file example-code

replace/case solution-code
	{author: ""}
	{author: "" ; you can write your name here, in quotes}

write solution-file solution-code


;     ===========================
print "        TESTS.TOML ..."

tests-toml: read tests-toml-file

foreach testcase cases-for-tests [
	append tests-toml rejoin [
		"# " testcase/description #"^/"
		mold testcase/uuid " = true^/^/"
	]
]

write tests-toml-file tests-toml


;     ===========================
print "   EXERCISE CONFIG FILE ..."

config-data: load-json read config-file

config-data/blurb: metadata/blurb
replace config-data/files/solution/1 "practice-exercise" slug
replace config-data/files/test/1 "practice-exercise" slug
append config-data/authors author

write config-file to-json/pretty config-data "^-"


;     ===========================
print "    UPDATE TRACK CONFIG ..."

track-config-data: load-json read track-config-file

exercise-config: make map! reduce [
	'slug slug
	'name metadata/title
	'status 'wip
	'uuid uuid
	'practices []
	'prerequisites []
	'difficulty 0
]

append track-config-data/exercises/practice exercise-config

write track-config-file rejoin [
	to-json/pretty track-config-data "  "
	"^/"
]

;     ===========================
print "          done."
