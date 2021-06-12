Red [
	description: {Tests for "Two-fer" Exercism exercise}
	author: "loziniak"
]

exercise-slug: "two-fer"
ignore-after: 3

comment [
	source:
		https://raw.githubusercontent.com/exercism/problem-specifications/main/exercises/two-fer/canonical-data.json

	{
	  "exercise": "two-fer",
	  "cases": [
	    {
	      "uuid": "1cf3e15a-a3d7-4a87-aeb3-ba1b43bc8dce",
	      "description": "no name given",
	      "property": "twoFer",
	      "input": {
	        "name": null
	      },
	      "expected": "One for you, one for me."
	    },
	    {
	      "uuid": "b4c6dbb8-b4fb-42c2-bafd-10785abe7709",
	      "description": "a name given",
	      "property": "twoFer",
	      "input": {
	        "name": "Alice"
	      },
	      "expected": "One for Alice, one for me."
	    },
	    {
	      "uuid": "3549048d-1a6e-4653-9a79-b0bda163e8d5",
	      "description": "another name given",
	      "property": "twoFer",
	      "input": {
	        "name": "Bob"
	      },
	      "expected": "One for Bob, one for me."
	    }
	  ]
	}

]

canonical-cases: [
	#(
		description: "no name given"
		input: #(name: none)
		expected: "One for you, one for me."
	)
	#(
		description: "a name given"
		input: #(name: "Alice")
		expected: "One for Alice, one for me."
	)
	#(
		description: "another name given"
		input: #(name: "Bob")
		expected: "One for Bob, one for me."
	)
]


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
