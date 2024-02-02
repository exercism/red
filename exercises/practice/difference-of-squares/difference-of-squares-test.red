Red [
	description: {Tests for "Difference of Squares" Exercism exercise}
	author: "loziniak"
]

#include %testlib.red

test-init/limit %difference-of-squares.red 1
; test-init/limit %.meta/example.red 1						; test example solution

canonical-cases: [#(
    description: "square of sum 1"
    input: #(
        number: 1
    )
    expected: 1
    function: "square-of-sum"
    uuid: "e46c542b-31fc-4506-bcae-6b62b3268537"
) #(
    description: "square of sum 5"
    input: #(
        number: 5
    )
    expected: 225
    function: "square-of-sum"
    uuid: "9b3f96cb-638d-41ee-99b7-b4f9c0622948"
) #(
    description: "square of sum 100"
    input: #(
        number: 100
    )
    expected: 25502500
    function: "square-of-sum"
    uuid: "54ba043f-3c35-4d43-86ff-3a41625d5e86"
) #(
    description: "sum of squares 1"
    input: #(
        number: 1
    )
    expected: 1
    function: "sum-of-squares"
    uuid: "01d84507-b03e-4238-9395-dd61d03074b5"
) #(
    description: "sum of squares 5"
    input: #(
        number: 5
    )
    expected: 55
    function: "sum-of-squares"
    uuid: "c93900cd-8cc2-4ca4-917b-dd3027023499"
) #(
    description: "sum of squares 100"
    input: #(
        number: 100
    )
    expected: 338350
    function: "sum-of-squares"
    uuid: "94807386-73e4-4d9e-8dec-69eb135b19e4"
) #(
    description: "difference of squares 1"
    input: #(
        number: 1
    )
    expected: 0
    function: "difference-of-squares"
    uuid: "44f72ae6-31a7-437f-858d-2c0837adabb6"
) #(
    description: "difference of squares 5"
    input: #(
        number: 5
    )
    expected: 170
    function: "difference-of-squares"
    uuid: "005cb2bf-a0c8-46f3-ae25-924029f8b00b"
) #(
    description: "difference of squares 100"
    input: #(
        number: 100
    )
    expected: 25164150
    function: "difference-of-squares"
    uuid: "b1bf19de-9a16-41c0-a62b-1f02ecc0b036"
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
