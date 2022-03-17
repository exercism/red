Red [
	description: {Tests for Darts Exercism exercise}
	author: "loziniak"
]

#include %testlib.red

test-init/limit %darts.red 1
; test-init/limit %.meta/example.red 1						; test example solution

canonical-cases: [#(
    description: "Missed target"
    input: #(
        x: -9
        y: 9
    )
    expected: 0
    function: "score"
    uuid: "9033f731-0a3a-4d9c-b1c0-34a1c8362afb"
) #(
    description: "On the outer circle"
    input: #(
        x: 0
        y: 10
    )
    expected: 1
    function: "score"
    uuid: "4c9f6ff4-c489-45fd-be8a-1fcb08b4d0ba"
) #(
    description: "On the middle circle"
    input: #(
        x: -5
        y: 0
    )
    expected: 5
    function: "score"
    uuid: "14378687-ee58-4c9b-a323-b089d5274be8"
) #(
    description: "On the inner circle"
    input: #(
        x: 0
        y: -1
    )
    expected: 10
    function: "score"
    uuid: "849e2e63-85bd-4fed-bc3b-781ae962e2c9"
) #(
    description: "Exactly on centre"
    input: #(
        x: 0
        y: 0
    )
    expected: 10
    function: "score"
    uuid: "1c5ffd9f-ea66-462f-9f06-a1303de5a226"
) #(
    description: "Near the centre"
    input: #(
        x: -0.1
        y: -0.1
    )
    expected: 10
    function: "score"
    uuid: "b65abce3-a679-4550-8115-4b74bda06088"
) #(
    description: "Just within the inner circle"
    input: #(
        x: 0.7
        y: 0.7
    )
    expected: 10
    function: "score"
    uuid: "66c29c1d-44f5-40cf-9927-e09a1305b399"
) #(
    description: "Just outside the inner circle"
    input: #(
        x: 0.8
        y: -0.8
    )
    expected: 5
    function: "score"
    uuid: "d1012f63-c97c-4394-b944-7beb3d0b141a"
) #(
    description: "Just within the middle circle"
    input: #(
        x: -3.5
        y: 3.5
    )
    expected: 5
    function: "score"
    uuid: "ab2b5666-b0b4-49c3-9b27-205e790ed945"
) #(
    description: "Just outside the middle circle"
    input: #(
        x: -3.6
        y: -3.6
    )
    expected: 1
    function: "score"
    uuid: "70f1424e-d690-4860-8caf-9740a52c0161"
) #(
    description: "Just within the outer circle"
    input: #(
        x: -7.0
        y: 7.0
    )
    expected: 1
    function: "score"
    uuid: "a7dbf8db-419c-4712-8a7f-67602b69b293"
) #(
    description: "Just outside the outer circle"
    input: #(
        x: 7.1
        y: -7.1
    )
    expected: 0
    function: "score"
    uuid: "e0f39315-9f9a-4546-96e4-a9475b885aa7"
) #(
    description: {Asymmetric position between the inner and middle circles}
    input: #(
        x: 0.5
        y: -4
    )
    expected: 5
    function: "score"
    uuid: "045d7d18-d863-4229-818e-b50828c75d19"
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
