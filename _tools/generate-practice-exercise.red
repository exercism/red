Red [
	author: "loziniak"
]


probe slug: system/script/args
probe slug: copy/part  skip slug 1  back tail slug
probe github-problem-spec: rejoin
	[https://raw.githubusercontent.com/exercism/problem-specifications/main/exercises/ slug]


uuid: copy ""
call/wait/output "uuidgen -r" uuid
remove back tail probe uuid						; remove newline



exercise-path: rejoin [%../exercises/practice/ slug]
call/wait rejoin ["cp -r ../_templates/practice-exercise " exercise-path]

rename
	rejoin [exercise-path %/practice-exercise.red]
	solution-file: rejoin [exercise-path %/ slug %.red]

rename
	rejoin [exercise-path %/practice-exercise-test.red]
	probe test-file: rejoin [exercise-path %/ slug %-test.red]

example-file: rejoin [exercise-path %/.meta/example.red]

tests-toml-file: rejoin [exercise-path %/.meta/tests.toml]

probe config-file: rejoin [exercise-path %/.meta/config.json]

track-config-file: %../config.json



metadata: make map! 
	load
		find/tail
			read rejoin [github-problem-spec %/metadata.yml]
			#"^/"

if none? metadata/title [
	metadata/title: title-case: copy slug

	until [
		change title-case
			uppercase first title-case
		title-case: find/tail title-case "-"
		none? title-case
	]

	metadata/title: head metadata/title
]

probe metadata



instructions: read/lines
	rejoin [github-problem-spec %/description.md]

instructions:  copy  skip instructions 2
write/lines/append  rejoin [exercise-path %/.docs/instructions.md]  instructions



canonical-data: load-json read 
	rejoin [github-problem-spec %/canonical-data.json]

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
				load-testcases testcase/cases			; recurrently load nested testcases
			]
	]
	loaded
]

probe cases-for-tests: load-testcases canonical-data/cases

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
	rejoin ["description: {Tests for " metadata/title " Exercism exercise}"]

test-code: replace/case test-code
	"practice-exercise"
	slug

write test-file probe test-code



probe solution-code: read solution-file

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
			"] [^/^-cause-error 'user 'message [^"You need to implement this function.^"]^/]^/^/"
		]
	]
]

write example-file solution-code

replace/case solution-code
	"author: ^"loziniak^""
	"author: ^"^" ; you can write your name here, in quotes"

write solution-file solution-code



tests-toml: read tests-toml-file

foreach testcase cases-for-tests [
	append tests-toml rejoin [
		"# " testcase/description #"^/"
		mold testcase/uuid " = true^/^/"
	]
]

write tests-toml-file tests-toml



config-data: load-json read config-file

config-data/blurb: metadata/blurb
replace config-data/files/solution/1 "practice-exercise" slug
replace config-data/files/test/1 "practice-exercise" slug

write config-file to-json/pretty probe config-data "^-"



track-config-data: load-json read track-config-file

exercise-config: make map! reduce [
	'slug slug
	'name metadata/title
	'staus 'wip
	'uuid uuid
	'practices []
	'prerequisites []
	'difficulty 0
]

append track-config-data/exercises/practice exercise-config

write track-config-file rejoin [
	to-json/pretty probe track-config-data "  "
	"^/"
]
