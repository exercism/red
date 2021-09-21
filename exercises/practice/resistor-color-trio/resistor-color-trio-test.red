Red [
	description: {Tests for Resistor Color Trio Exercism exercise}
	author: "loziniak"
]

exercise-slug: "resistor-color-trio"
ignore-after: 1


canonical-cases: [#(
    description: "Orange and orange and black"
    input: #(
        colors: ["orange" "orange" "black"]
    )
    expected: #(
        value: 33
        unit: "ohms"
    )
    function: "label"
    uuid: "d6863355-15b7-40bb-abe0-bfb1a25512ed"
) #(
    description: "Blue and grey and brown"
    input: #(
        colors: ["blue" "grey" "brown"]
    )
    expected: #(
        value: 680
        unit: "ohms"
    )
    function: "label"
    uuid: "1224a3a9-8c8e-4032-843a-5224e04647d6"
) #(
    description: "Red and black and red"
    input: #(
        colors: ["red" "black" "red"]
    )
    expected: #(
        value: 2
        unit: "kiloohms"
    )
    function: "label"
    uuid: "b8bda7dc-6b95-4539-abb2-2ad51d66a207"
) #(
    description: "Green and brown and orange"
    input: #(
        colors: ["green" "brown" "orange"]
    )
    expected: #(
        value: 51
        unit: "kiloohms"
    )
    function: "label"
    uuid: "5b1e74bc-d838-4eda-bbb3-eaba988e733b"
) #(
    description: "Yellow and violet and yellow"
    input: #(
        colors: ["yellow" "violet" "yellow"]
    )
    expected: #(
        value: 470
        unit: "kiloohms"
    )
    function: "label"
    uuid: "f5d37ef9-1919-4719-a90d-a33c5a6934c9"
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
