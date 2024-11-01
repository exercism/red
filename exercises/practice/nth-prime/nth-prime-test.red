Red [
	description: {Tests for "Nth Prime" Exercism exercise}
	author: "loziniak"
]

#include %testlib.red

test-init/limit %nth-prime.red 1
; test-init/limit %.meta/example.red 1						; test example solution

canonical-cases: [#[
    description: "first prime"
    input: #[
        number: 1
    ]
    expected: 2
    function: "prime"
    uuid: "75c65189-8aef-471a-81de-0a90c728160c"
] #[
    description: "second prime"
    input: #[
        number: 2
    ]
    expected: 3
    function: "prime"
    uuid: "2c38804c-295f-4701-b728-56dea34fd1a0"
] #[
    description: "sixth prime"
    input: #[
        number: 6
    ]
    expected: 13
    function: "prime"
    uuid: "56692534-781e-4e8c-b1f9-3e82c1640259"
] #[
    description: "big prime"
    input: #[
        number: 10001
    ]
    expected: 104743
    function: "prime"
    uuid: "fce1e979-0edb-412d-93aa-2c744e8f50ff"
] #[
    description: "there is no zeroth prime"
    input: #[
        number: 0
    ]
    expected: #[
        error: "there is no zeroth prime"
    ]
    function: "prime"
    uuid: "bd0a9eae-6df7-485b-a144-80e13c7d55b2"
]]


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
