Red [
	description: {Tests for "Grains" Exercism exercise}
	author: "loziniak"
]

#include %testlib.red

 test-init/limit %grains.red 1
; test-init/limit %.meta/example.red 1						; test example solution

canonical-cases: [#(
    description: "grains on square 1"
    input: #(
        square: 1
    )
    expected: 1
    function: "square"
    uuid: "9fbde8de-36b2-49de-baf2-cd42d6f28405"
) #(
    description: "grains on square 2"
    input: #(
        square: 2
    )
    expected: 2
    function: "square"
    uuid: "ee1f30c2-01d8-4298-b25d-c677331b5e6d"
) #(
    description: "grains on square 3"
    input: #(
        square: 3
    )
    expected: 4
    function: "square"
    uuid: "10f45584-2fc3-4875-8ec6-666065d1163b"
) #(
    description: "grains on square 4"
    input: #(
        square: 4
    )
    expected: 8
    function: "square"
    uuid: "a7cbe01b-36f4-4601-b053-c5f6ae055170"
) #(
    description: "grains on square 16"
    input: #(
        square: 16
    )
    expected: 32768
    function: "square"
    uuid: "c50acc89-8535-44e4-918f-b848ad2817d4"
) #(
    description: "grains on square 32"
    input: #(
        square: 32
    )
    expected: 2147483648.0
    function: "square"
    uuid: "acd81b46-c2ad-4951-b848-80d15ed5a04f"
) #(
    description: "grains on square 64"
    input: #(
        square: 64
    )
    expected: 9.223372036854776e18
    function: "square"
    uuid: "c73b470a-5efb-4d53-9ac6-c5f6487f227b"
) #(
    description: "square 0 is invalid"
    input: #(
        square: 0
    )
    expected: #(
        error: "square must be between 1 and 64"
    )
    function: "square"
    uuid: "1d47d832-3e85-4974-9466-5bd35af484e3"
) #(
    description: "negative square is invalid"
    input: #(
        square: -1
    )
    expected: #(
        error: "square must be between 1 and 64"
    )
    function: "square"
    uuid: "61974483-eeb2-465e-be54-ca5dde366453"
) #(
    description: "square greater than 64 is invalid"
    input: #(
        square: 65
    )
    expected: #(
        error: "square must be between 1 and 64"
    )
    function: "square"
    uuid: "a95e4374-f32c-45a7-a10d-ffec475c012f"
) #(
    description: "returns the total number of grains on the board"
    input: #()
    expected: 18446744073709551615
    function: "total"
    uuid: "6eb07385-3659-4b45-a6be-9dc474222750"
)]


foreach c-case canonical-cases [
	expect-code: compose [
		(to word! c-case/function) (values-of c-case/input)
	]
	case-code: reduce
		either all [
			map? c-case/expected
			string? c-case/expected/error
		] [
			['expect-error/message quote 'user expect-code c-case/expected/error]
		] [
			['expect c-case/expected expect-code]
		]

	test c-case/description case-code
]

test-results/print
