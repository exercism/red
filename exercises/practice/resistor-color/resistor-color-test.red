Red [
	description: {Tests for Resistor Color Exercism exercise}
	author: "loziniak"
]

exercise-slug: "resistor-color"
ignore-after: 1


canonical-cases: [#(
    description: "Black"
    input: #(
        color: "black"
    )
    expected: 0
    function: "color-code"
    uuid: "49eb31c5-10a8-4180-9f7f-fea632ab87ef"
) #(
    description: "White"
    input: #(
        color: "white"
    )
    expected: 9
    function: "color-code"
    uuid: "0a4df94b-92da-4579-a907-65040ce0b3fc"
) #(
    description: "Orange"
    input: #(
        color: "orange"
    )
    expected: 3
    function: "color-code"
    uuid: "5f81608d-f36f-4190-8084-f45116b6f380"
) #(
    description: "Colors"
    input: #()
    expected: ["black" "brown" "red" "orange" "yellow" "green" "blue" "violet" "grey" "white"]
    function: "colors"
    uuid: "581d68fa-f968-4be2-9f9d-880f2fb73cf7"
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
