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
	result: do
		to file! rejoin [exercise-slug %.red]

	if function? :result [			;-- execute function
		result: do
			append
				copy [result]
				values-of test-case/input
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
