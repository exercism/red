Red [
	description: {Tests for "Armstrong Numbers" Exercism exercise}
	author: "loziniak"
]

#include %testlib.red

test-init/limit %armstrong-numbers.red 1
; test-init/limit %.meta/example.red 1						; test example solution

canonical-cases: [#[
    description: "Zero is an Armstrong number"
    input: #[
        number: 0
    ]
    expected: true
    function: "is-armstrong-number"
    uuid: "c1ed103c-258d-45b2-be73-d8c6d9580c7b"
] #[
    description: "Single-digit numbers are Armstrong numbers"
    input: #[
        number: 5
    ]
    expected: true
    function: "is-armstrong-number"
    uuid: "579e8f03-9659-4b85-a1a2-d64350f6b17a"
] #[
    description: "There are no two-digit Armstrong numbers"
    input: #[
        number: 10
    ]
    expected: false
    function: "is-armstrong-number"
    uuid: "2d6db9dc-5bf8-4976-a90b-b2c2b9feba60"
] #[
    description: "Three-digit number that is an Armstrong number"
    input: #[
        number: 153
    ]
    expected: true
    function: "is-armstrong-number"
    uuid: "509c087f-e327-4113-a7d2-26a4e9d18283"
] #[
    description: {Three-digit number that is not an Armstrong number}
    input: #[
        number: 100
    ]
    expected: false
    function: "is-armstrong-number"
    uuid: "7154547d-c2ce-468d-b214-4cb953b870cf"
] #[
    description: "Four-digit number that is an Armstrong number"
    input: #[
        number: 9474
    ]
    expected: true
    function: "is-armstrong-number"
    uuid: "6bac5b7b-42e9-4ecb-a8b0-4832229aa103"
] #[
    description: "Four-digit number that is not an Armstrong number"
    input: #[
        number: 9475
    ]
    expected: false
    function: "is-armstrong-number"
    uuid: "eed4b331-af80-45b5-a80b-19c9ea444b2e"
] #[
    description: "Seven-digit number that is an Armstrong number"
    input: #[
        number: 9926315
    ]
    expected: true
    function: "is-armstrong-number"
    uuid: "f971ced7-8d68-4758-aea1-d4194900b864"
] #[
    description: {Seven-digit number that is not an Armstrong number}
    input: #[
        number: 9926314
    ]
    expected: false
    function: "is-armstrong-number"
    uuid: "7ee45d52-5d35-4fbd-b6f1-5c8cd8a67f18"
]]


foreach c-case canonical-cases [
	case-code: reduce [
		'expect c-case/expected compose [
			(to word! c-case/function) (values-of c-case/input)
		] 
	]

	test c-case/description case-code
]

test-results/print
