Red [
	description: {Tests for "Hello World" Exercism exercise}
	author: "loziniak"
]

exercise-slug: "hello-world"
ignore-after: 1

canonical-config: load-json read rejoin [
	https://raw.githubusercontent.com/exercism/problem-specifications/main/exercises/
	exercise-slug
	"/canonical-data.json"
]


print ["Testing" ignore-after "cases…"]

cases: copy/deep/part canonical-config/cases ignore-after
foreach test-case cases [
	result: do
		to file! rejoin [exercise-slug %.red]

	if function? :result [
		result: result			; execute function
	]

	print [
		pad/with test-case/description 30 #"."
		either result = test-case/expected [
			"✓"
		] [
			rejoin ["FAILED. Expected: ^"" test-case/expected "^", but got ^"" result "^""]
		]
	]
]

print [
	(length? canonical-config/cases) - ignore-after
	"cases ignored."
]
