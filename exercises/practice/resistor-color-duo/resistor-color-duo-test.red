Red [
	description: {Tests for Resistor Color Duo Exercism exercise}
	author: "loziniak"
]

#include %testlib.red

test-init/limit %resistor-color-duo.red 1
; test-init/limit %.meta/example.red 1						; test example solution

canonical-cases: [#(
    description: "Brown and black"
    input: #(
        colors: ["brown" "black"]
    )
    expected: 10
    function: "value"
    uuid: "ce11995a-5b93-4950-a5e9-93423693b2fc"
) #(
    description: "Blue and grey"
    input: #(
        colors: ["blue" "grey"]
    )
    expected: 68
    function: "value"
    uuid: "7bf82f7a-af23-48ba-a97d-38d59406a920"
) #(
    description: "Yellow and violet"
    input: #(
        colors: ["yellow" "violet"]
    )
    expected: 47
    function: "value"
    uuid: "f1886361-fdfd-4693-acf8-46726fe24e0c"
) #(
    description: "Orange and orange"
    input: #(
        colors: ["orange" "orange"]
    )
    expected: 33
    function: "value"
    uuid: "77a8293d-2a83-4016-b1af-991acc12b9fe"
) #(
    description: "Ignore additional colors"
    input: #(
        colors: ["green" "brown" "orange"]
    )
    expected: 51
    function: "value"
    uuid: "0c4fb44f-db7c-4d03-afa8-054350f156a8"
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
