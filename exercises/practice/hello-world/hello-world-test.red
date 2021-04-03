Red [
	description: {Tests for "Hello World" Exercism exercise}
	author: "loziniak"
]

exercise-slug: "hello-world"
ignore-after: 1

comment [
	source:
		https://raw.githubusercontent.com/exercism/problem-specifications/main/exercises/hello-world/canonical-data.json

	{
	  "exercise": "hello-world",
	  "cases": [
	    {
	      "uuid": "af9ffe10-dc13-42d8-a742-e7bdafac449d",
	      "description": "Say Hi!",
	      "property": "hello",
	      "input": {},
	      "expected": "Hello, World!"
	    }
	  ]
	}
]

canonical-cases: [#(
    description: "Say Hi!"
    input: #()
    expected: "Hello, World!"
)]


print ["Testing" ignore-after "cases…"]

cases: copy/deep/part canonical-cases ignore-after
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
			rejoin [{FAILED. Expected: "} test-case/expected {", but got "} result {"}]
		]
	]
]

print [
	(length? canonical-cases) - ignore-after
	"cases ignored."
]
