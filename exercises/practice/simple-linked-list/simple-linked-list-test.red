Red [
	description: {Tests for "Simple Linked List" Exercism exercise}
	author: "loziniak"
]

#include %testlib.red

test-init/limit %simple-linked-list.red 1
; test-init/limit %.meta/example.red 1						; test example solution

canonical-cases: [#(
    description: {Convert an array to linked list, and then from linked list back to array}
    input: #(
        array: [3 6 1]
    )
    expected: [3 6 1]
    function: "from-array-and-back"
    uuid: "3b72d23a-4487-4632-8682-59684c875dd9"
) #(
    description: {Convert from array, reverse the list, and covert to array}
    input: #(
        array: [3 6 1]
    )
    expected: [1 6 3]
    function: "convert-reverse-convert-back"
    uuid: "70484949-cf28-4446-af05-e24f5ae8a265"
)]


foreach c-case canonical-cases [
	case-code: reduce [
		'expect c-case/expected compose [
			(to word! c-case/function) (values-of c-case/input)
		] 
	]

	test c-case/description case-code
]
