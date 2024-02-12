Red [
	description: {Tests for Resistor Color Trio Exercism exercise}
	author: "loziniak"
]

#include %testlib.red

test-init/limit %resistor-color-trio.red 1
; test-init/limit %.meta/example.red 1						; test example solution

canonical-cases: [#[
    description: "Orange and orange and black"
    input: #[
        colors: ["orange" "orange" "black"]
    ]
    expected: #[
        value: 33
        unit: "ohms"
    ]
    function: "label"
    uuid: "d6863355-15b7-40bb-abe0-bfb1a25512ed"
] #[
    description: "Blue and grey and brown"
    input: #[
        colors: ["blue" "grey" "brown"]
    ]
    expected: #[
        value: 680
        unit: "ohms"
    ]
    function: "label"
    uuid: "1224a3a9-8c8e-4032-843a-5224e04647d6"
] #[
    description: "Red and black and red"
    input: #[
        colors: ["red" "black" "red"]
    ]
    expected: #[
        value: 2
        unit: "kiloohms"
    ]
    function: "label"
    uuid: "b8bda7dc-6b95-4539-abb2-2ad51d66a207"
] #[
    description: "Green and brown and orange"
    input: #[
        colors: ["green" "brown" "orange"]
    ]
    expected: #[
        value: 51
        unit: "kiloohms"
    ]
    function: "label"
    uuid: "5b1e74bc-d838-4eda-bbb3-eaba988e733b"
] #[
    description: "Yellow and violet and yellow"
    input: #[
        colors: ["yellow" "violet" "yellow"]
    ]
    expected: #[
        value: 470
        unit: "kiloohms"
    ]
    function: "label"
    uuid: "f5d37ef9-1919-4719-a90d-a33c5a6934c9"
] #[
    description: "Blue and violet and blue"
    input: #[
        colors: ["blue" "violet" "blue"]
    ]
    expected: #[
        value: 67
        unit: "megaohms"
    ]
    function: "label"
    uuid: "5f6404a7-5bb3-4283-877d-3d39bcc33854"
] #[
    description: "Minimum possible value"
    input: #[
        colors: ["black" "black" "black"]
    ]
    expected: #[
        value: 0
        unit: "ohms"
    ]
    function: "label"
    uuid: "7d3a6ab8-e40e-46c3-98b1-91639fff2344"
] #[
    description: "Maximum possible value"
    input: #[
        colors: ["white" "white" "white"]
    ]
    expected: #[
        value: 99
        unit: "gigaohms"
    ]
    function: "label"
    uuid: "ca0aa0ac-3825-42de-9f07-dac68cc580fd"
] #[
    description: "First two colors make an invalid octal number"
    input: #[
        colors: ["black" "grey" "black"]
    ]
    expected: #[
        value: 8
        unit: "ohms"
    ]
    function: "label"
    uuid: "0061a76c-903a-4714-8ce2-f26ce23b0e09"
] #[
    description: "Ignore extra colors"
    input: #[
        colors: ["blue" "green" "yellow" "orange"]
    ]
    expected: #[
        value: 650
        unit: "kiloohms"
    ]
    function: "label"
    uuid: "872c92-f567-4b69-a105-8455611c10c4"
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
