Red [
	description: "Practice exercise generator for Exercism's Red track"
	usage: {
		"red generate-practice-exercise.red <exercise-slug> <github-username> [difficulty]"
		"red generate-practice-exercise.red --sync-tests <exercise-slug>"
	}
	author: "loziniak"
]

raw-arguments: trim/with copy system/script/args {"'}
arguments: split raw-arguments " "
argument-count: length? arguments

sync-tests?: false
if not empty? arguments [
	sync-tests?: (first arguments) = "--sync-tests"
]

either sync-tests? [
	if 2 <> argument-count [
		print {Usage: red generate-practice-exercise.red --sync-tests <exercise-slug>}
		quit
	]

	slug: second arguments
] [
	if not all [
		argument-count >= 2
		argument-count <= 3
	] [
		print {Usage: red generate-practice-exercise.red <exercise-slug> <github-username> [difficulty]}
		quit
	]

	slug: first arguments
	author: second arguments
	difficulty: any [third arguments "1"]
]


;     ===========================
print "          PATHS ..."

problem-specifications-url: rejoin
	[https://raw.githubusercontent.com/exercism/problem-specifications/main/exercises/ slug]

exercise-path: rejoin [%../exercises/practice/ slug]
template-path: %../_templates/practice-exercise

if not sync-tests? [
	print "    CONFIGLET CREATE ..."
	call/wait rejoin [
		to-local-file %../bin/configlet
		" create --practice-exercise " slug
		" --author " author
		" --difficulty " difficulty
	]

	print "SORT PRACTICE EXERCISES ..."
	call/wait rejoin [
		to-local-file %../bin/sort-practice-exercises
		{ ".bucket, .lowercase_name" }
		to-local-file %../config.json
	]

	; Copy only Red-specific templates, preserving Configlet-created .meta files.
	copy-template: function [source [file!] destination [file!]] [
		write destination read rejoin [template-path %/ source]
	]

	solution-file: rejoin [exercise-path %/ slug %.red]
	copy-template %practice-exercise.red solution-file
	copy-template %practice-exercise-test.red rejoin [exercise-path %/ slug %-test.red]
	copy-template %testlib.red rejoin [exercise-path %/testlib.red]
	copy-template %.meta/example.red rejoin [exercise-path %/.meta/example.red]

	example-file: rejoin [exercise-path %/.meta/example.red]
]

test-file: rejoin [exercise-path %/ slug %-test.red]

tests-toml-file: rejoin [exercise-path %/.meta/tests.toml]


;     ===========================
print "       EXERCISE TITLE ..."

track-config-data: load-json read %../config.json
foreach practice-exercise track-config-data/exercises/practice [
	if practice-exercise/slug = slug [
		title: practice-exercise/name
	]
]


;     ===========================
print "       TEST SUITE ..."

canonical-data: load-json read
	rejoin [problem-specifications-url %/canonical-data.json]

tests-toml: read tests-toml-file

testcase-included?: function [uuid [string!]] [
	section-start: find tests-toml rejoin ["[" uuid "]"]
	either none? section-start [
		false
	] [
		section-end: any [find next section-start "^/[" tail tests-toml]
		none? find copy/part section-start section-end "include = false"
	]
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
				either testcase-included? testcase/uuid [
					make map! reduce [
						'description testcase/description
						'input testcase/input
						'expected testcase/expected
						'function camel-to-kebab-case testcase/property
						'uuid testcase/uuid
					]
				] [
					[]
				]
			] [
				load-testcases testcase/cases				; recurrently load nested testcases
			]
	]
	loaded
]

cases-for-tests: load-testcases canonical-data/cases

test-code: read test-file

canonical-cases-start: find test-code "canonical-cases:"
canonical-cases-end: find canonical-cases-start "foreach c-case canonical-cases"
change/part canonical-cases-start rejoin [
	"canonical-cases: "
	mold cases-for-tests
	"^/^/"
] canonical-cases-end

test-code: replace/case test-code
	{description: {Tests for "Practie Exercise" Exercism exercise}}
	rejoin ["description: {Tests for ^"" title "^" Exercism exercise}"]

test-code: replace/case test-code
	"practice-exercise"
	slug

write test-file test-code

if sync-tests? [
	print "          done."
	quit
]

;     ===========================
print "      SOLUTION STUB ..."

solution-code: read solution-file

solution-code: replace/case solution-code
	"Practice Exercise"
	title

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
print "          done."
