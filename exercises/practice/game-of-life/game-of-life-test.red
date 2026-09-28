Red [
	description: {Tests for "Conway's Game of Life" Exercism exercise}
	author: "loziniak"
]

#include %testlib.red

test-init/limit %game-of-life.red 1
; test-init/limit %.meta/example.red 1						; test example solution

canonical-cases: [#[
    description: "empty matrix"
    input: #[
        matrix: []
    ]
    expected: []
    function: "tick"
    uuid: "ae86ea7d-bd07-4357-90b3-ac7d256bd5c5"
] #[
    description: "live cells with zero live neighbors die"
    input: #[
        matrix: [[0 0 0] [0 1 0] [0 0 0]]
    ]
    expected: [[0 0 0] [0 0 0] [0 0 0]]
    function: "tick"
    uuid: "4ea5ccb7-7b73-4281-954a-bed1b0f139a5"
] #[
    description: "live cells with only one live neighbor die"
    input: #[
        matrix: [[0 0 0] [0 1 0] [0 1 0]]
    ]
    expected: [[0 0 0] [0 0 0] [0 0 0]]
    function: "tick"
    uuid: "df245adc-14ff-4f9c-b2ae-f465ef5321b2"
] #[
    description: "live cells with two live neighbors stay alive"
    input: #[
        matrix: [[1 0 1] [1 0 1] [1 0 1]]
    ]
    expected: [[0 0 0] [1 0 1] [0 0 0]]
    function: "tick"
    uuid: "2a713b56-283c-48c8-adae-1d21306c80ae"
] #[
    description: "live cells with three live neighbors stay alive"
    input: #[
        matrix: [[0 1 0] [1 0 0] [1 1 0]]
    ]
    expected: [[0 0 0] [1 0 0] [1 1 0]]
    function: "tick"
    uuid: "86d5c5a5-ab7b-41a1-8907-c9b3fc5e9dae"
] #[
    description: "dead cells with three live neighbors become alive"
    input: #[
        matrix: [[1 1 0] [0 0 0] [1 0 0]]
    ]
    expected: [[0 0 0] [1 1 0] [0 0 0]]
    function: "tick"
    uuid: "015f60ac-39d8-4c6c-8328-57f334fc9f89"
] #[
    description: "live cells with four or more neighbors die"
    input: #[
        matrix: [[1 1 1] [1 1 1] [1 1 1]]
    ]
    expected: [[1 0 1] [0 0 0] [1 0 1]]
    function: "tick"
    uuid: "2ee69c00-9d41-4b8b-89da-5832e735ccf1"
] #[
    description: "bigger matrix"
    input: #[
        matrix: [[1 1 0 1 1 0 0 0] [1 0 1 1 0 0 0 0] [1 1 1 0 0 1 1 1] [0 0 0 0 0 1 1 0] [1 0 0 0 1 1 0 0] [1 1 0 0 0 1 1 1] [0 0 1 0 1 0 0 1] [1 0 0 0 0 0 1 1]]
    ]
    expected: [[1 1 0 1 1 0 0 0] [0 0 0 0 0 1 1 0] [1 0 1 1 1 1 0 1] [1 0 0 0 0 0 0 1] [1 1 0 0 1 0 0 1] [1 1 0 1 0 0 0 1] [1 0 0 0 0 0 0 0] [0 0 0 0 0 0 1 1]]
    function: "tick"
    uuid: "a79b42be-ed6c-4e27-9206-43da08697ef6"
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
