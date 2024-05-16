Red [
	description: {Tests for "Secret Handshake" Exercism exercise}
	author: "loziniak"
]

#include %testlib.red

test-init/limit %secret-handshake.red 1
; test-init/limit %.meta/example.red 1						; test example solution

canonical-cases: [#[
    description: "wink for 1"
    input: #[
        number: 1
    ]
    expected: ["wink"]
    function: "commands"
    uuid: "b8496fbd-6778-468c-8054-648d03c4bb23"
] #[
    description: "double blink for 10"
    input: #[
        number: 2
    ]
    expected: ["double blink"]
    function: "commands"
    uuid: "83ec6c58-81a9-4fd1-bfaf-0160514fc0e3"
] #[
    description: "close your eyes for 100"
    input: #[
        number: 4
    ]
    expected: ["close your eyes"]
    function: "commands"
    uuid: "0e20e466-3519-4134-8082-5639d85fef71"
] #[
    description: "jump for 1000"
    input: #[
        number: 8
    ]
    expected: ["jump"]
    function: "commands"
    uuid: "b339ddbb-88b7-4b7d-9b19-4134030d9ac0"
] #[
    description: "combine two actions"
    input: #[
        number: 3
    ]
    expected: ["wink" "double blink"]
    function: "commands"
    uuid: "40499fb4-e60c-43d7-8b98-0de3ca44e0eb"
] #[
    description: "reverse two actions"
    input: #[
        number: 19
    ]
    expected: ["double blink" "wink"]
    function: "commands"
    uuid: "9730cdd5-ef27-494b-afd3-5c91ad6c3d9d"
] #[
    description: "reversing one action gives the same action"
    input: #[
        number: 24
    ]
    expected: ["jump"]
    function: "commands"
    uuid: "0b828205-51ca-45cd-90d5-f2506013f25f"
] #[
    description: "reversing no actions still gives no actions"
    input: #[
        number: 16
    ]
    expected: []
    function: "commands"
    uuid: "9949e2ac-6c9c-4330-b685-2089ab28b05f"
] #[
    description: "all possible actions"
    input: #[
        number: 15
    ]
    expected: ["wink" "double blink" "close your eyes" "jump"]
    function: "commands"
    uuid: "23fdca98-676b-4848-970d-cfed7be39f81"
] #[
    description: "reverse all possible actions"
    input: #[
        number: 31
    ]
    expected: ["jump" "close your eyes" "double blink" "wink"]
    function: "commands"
    uuid: "ae8fe006-d910-4d6f-be00-54b7c3799e79"
] #[
    description: "do nothing for zero"
    input: #[
        number: 0
    ]
    expected: []
    function: "commands"
    uuid: "3d36da37-b31f-4cdb-a396-d93a2ee1c4a5"
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
