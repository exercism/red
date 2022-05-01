Red [
	description: {Tests for Resistor Color Exercism exercise}
	author: "loziniak"
]

#include %testlib.red

test-init/limit %resistor-color.red 1
; test-init/limit %.meta/example.red 1						; test example solution

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


foreach c-case canonical-cases [
	case-code: reduce [
		'expect c-case/expected compose [
			(to word! c-case/function) (values-of c-case/input)
		] 
	]

	test c-case/description case-code
]

test-results/print
