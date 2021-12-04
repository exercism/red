Red [
	description: {Tests for "Practie Exercise" Exercism exercise}
	author: "loziniak"
]

exercise-slug: "practice-exercise"
ignore-after: 1


canonical-cases: []


print ["Testing" ignore-after "cases…"]

cases: copy/deep/part canonical-cases ignore-after
foreach test-case cases [
	result: context load to file!
		rejoin [exercise-slug %.red]
	;	%.meta/example.red						; test example solution

	; function name
	result-execution: reduce [
		make path! reduce [
			'result
			to word! test-case/function
		]
	]
	; arguments
	append result-execution values-of test-case/input

	result: try [
		catch [
			do result-execution
		]
	]

	if error? result [
		either result/type = 'user [
			result: make map! reduce ['error result/arg1]
		] [
			print result
		]
	]

	print [
		pad/with test-case/description 30 #"."
		either result = test-case/expected [
			"✓"
		] [
			rejoin [{FAILED. Expected: "} test-case/expected {", but got "} result {"}]
		]
	]
]

print [
	(length? canonical-cases) - ignore-after
	"cases ignored."
]
