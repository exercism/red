Red [
	description: {Tests for "D&D Character" Exercism exercise}
	author: "loziniak"
]

#include %testlib.red

test-init/limit %dnd-character.red 1
; test-init/limit %.meta/example.red 1						; test example solution

canonical-cases: [#[
    description: "ability modifier for score 3 is -4"
    input: #[
        score: 3
    ]
    expected: -4
    function: "modifier"
    uuid: "1e9ae1dc-35bd-43ba-aa08-e4b94c20fa37"
] #[
    description: "ability modifier for score 4 is -3"
    input: #[
        score: 4
    ]
    expected: -3
    function: "modifier"
    uuid: "cc9bb24e-56b8-4e9e-989d-a0d1a29ebb9c"
] #[
    description: "ability modifier for score 5 is -3"
    input: #[
        score: 5
    ]
    expected: -3
    function: "modifier"
    uuid: "5b519fcd-6946-41ee-91fe-34b4f9808326"
] #[
    description: "ability modifier for score 6 is -2"
    input: #[
        score: 6
    ]
    expected: -2
    function: "modifier"
    uuid: "dc2913bd-6d7a-402e-b1e2-6d568b1cbe21"
] #[
    description: "ability modifier for score 7 is -2"
    input: #[
        score: 7
    ]
    expected: -2
    function: "modifier"
    uuid: "099440f5-0d66-4b1a-8a10-8f3a03cc499f"
] #[
    description: "ability modifier for score 8 is -1"
    input: #[
        score: 8
    ]
    expected: -1
    function: "modifier"
    uuid: "cfda6e5c-3489-42f0-b22b-4acb47084df0"
] #[
    description: "ability modifier for score 9 is -1"
    input: #[
        score: 9
    ]
    expected: -1
    function: "modifier"
    uuid: "c70f0507-fa7e-4228-8463-858bfbba1754"
] #[
    description: "ability modifier for score 10 is 0"
    input: #[
        score: 10
    ]
    expected: 0
    function: "modifier"
    uuid: "6f4e6c88-1cd9-46a0-92b8-db4a99b372f7"
] #[
    description: "ability modifier for score 11 is 0"
    input: #[
        score: 11
    ]
    expected: 0
    function: "modifier"
    uuid: "e00d9e5c-63c8-413f-879d-cd9be9697097"
] #[
    description: "ability modifier for score 12 is +1"
    input: #[
        score: 12
    ]
    expected: 1
    function: "modifier"
    uuid: "eea06f3c-8de0-45e7-9d9d-b8cab4179715"
] #[
    description: "ability modifier for score 13 is +1"
    input: #[
        score: 13
    ]
    expected: 1
    function: "modifier"
    uuid: "9c51f6be-db72-4af7-92ac-b293a02c0dcd"
] #[
    description: "ability modifier for score 14 is +2"
    input: #[
        score: 14
    ]
    expected: 2
    function: "modifier"
    uuid: "94053a5d-53b6-4efc-b669-a8b5098f7762"
] #[
    description: "ability modifier for score 15 is +2"
    input: #[
        score: 15
    ]
    expected: 2
    function: "modifier"
    uuid: "8c33e7ca-3f9f-4820-8ab3-65f2c9e2f0e2"
] #[
    description: "ability modifier for score 16 is +3"
    input: #[
        score: 16
    ]
    expected: 3
    function: "modifier"
    uuid: "c3ec871e-1791-44d0-b3cc-77e5fb4cd33d"
] #[
    description: "ability modifier for score 17 is +3"
    input: #[
        score: 17
    ]
    expected: 3
    function: "modifier"
    uuid: "3d053cee-2888-4616-b9fd-602a3b1efff4"
] #[
    description: "ability modifier for score 18 is +4"
    input: #[
        score: 18
    ]
    expected: 4
    function: "modifier"
    uuid: "bafd997a-e852-4e56-9f65-14b60261faee"
] #[
    description: "random ability is within range"
    input: #[]
    expected: true
    function: "test-ability"
    uuid: "4f28f19c-2e47-4453-a46a-c0d365259c14"
] #[
    description: "random character is valid"
    input: #[]
    expected: true
    function: "test-random-character-valid"
    uuid: "385d7e72-864f-4e88-8279-81a7d75b04ad"
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
