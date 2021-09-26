Red [
	description: {Tests for Space Age Exercism exercise}
	author: "loziniak"
]

exercise-slug: "space-age"
ignore-after: 1


canonical-cases: [#(
    description: "age on Earth"
    input: #(
        planet: "Earth"
        seconds: 1000000000
    )
    expected: 31.69
    function: "age"
    uuid: "84f609af-5a91-4d68-90a3-9e32d8a5cd34"
) #(
    description: "age on Mercury"
    input: #(
        planet: "Mercury"
        seconds: 2134835688
    )
    expected: 280.88
    function: "age"
    uuid: "ca20c4e9-6054-458c-9312-79679ffab40b"
) #(
    description: "age on Venus"
    input: #(
        planet: "Venus"
        seconds: 189839836
    )
    expected: 9.78
    function: "age"
    uuid: "502c6529-fd1b-41d3-8fab-65e03082b024"
) #(
    description: "age on Mars"
    input: #(
        planet: "Mars"
        seconds: 2129871239
    )
    expected: 35.88
    function: "age"
    uuid: "9ceadf5e-a0d5-4388-9d40-2c459227ceb8"
) #(
    description: "age on Jupiter"
    input: #(
        planet: "Jupiter"
        seconds: 901876382
    )
    expected: 2.41
    function: "age"
    uuid: "42927dc3-fe5e-4f76-a5b5-f737fc19bcde"
) #(
    description: "age on Saturn"
    input: #(
        planet: "Saturn"
        seconds: 2000000000
    )
    expected: 2.15
    function: "age"
    uuid: "8469b332-7837-4ada-b27c-00ee043ebcad"
) #(
    description: "age on Uranus"
    input: #(
        planet: "Uranus"
        seconds: 1210123456
    )
    expected: 0.46
    function: "age"
    uuid: "999354c1-76f8-4bb5-a672-f317b6436743"
) #(
    description: "age on Neptune"
    input: #(
        planet: "Neptune"
        seconds: 1821023456
    )
    expected: 0.35
    function: "age"
    uuid: "80096d30-a0d4-4449-903e-a381178355d8"
)]



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

	result: do result-execution

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
