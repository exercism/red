Red [
	description: {Tests for "Yacht" Exercism exercise}
	author: "loziniak"
]

#include %testlib.red

test-init/limit %yacht.red 1
; test-init/limit %.meta/example.red 1						; test example solution

canonical-cases: [#[
    description: "Yacht"
    input: #[
        dice: [5 5 5 5 5]
        category: "yacht"
    ]
    expected: 50
    function: "score"
    uuid: "3060e4a5-4063-4deb-a380-a630b43a84b6"
] #[
    description: "Not Yacht"
    input: #[
        dice: [1 3 3 2 5]
        category: "yacht"
    ]
    expected: 0
    function: "score"
    uuid: "15026df2-f567-482f-b4d5-5297d57769d9"
] #[
    description: "Ones"
    input: #[
        dice: [1 1 1 3 5]
        category: "ones"
    ]
    expected: 3
    function: "score"
    uuid: "36b6af0c-ca06-4666-97de-5d31213957a4"
] #[
    description: "Ones, out of order"
    input: #[
        dice: [3 1 1 5 1]
        category: "ones"
    ]
    expected: 3
    function: "score"
    uuid: "023a07c8-6c6e-44d0-bc17-efc5e1b8205a"
] #[
    description: "No ones"
    input: #[
        dice: [4 3 6 5 5]
        category: "ones"
    ]
    expected: 0
    function: "score"
    uuid: "7189afac-cccd-4a74-8182-1cb1f374e496"
] #[
    description: "Twos"
    input: #[
        dice: [2 3 4 5 6]
        category: "twos"
    ]
    expected: 2
    function: "score"
    uuid: "793c4292-dd14-49c4-9707-6d9c56cee725"
] #[
    description: "Fours"
    input: #[
        dice: [1 4 1 4 1]
        category: "fours"
    ]
    expected: 8
    function: "score"
    uuid: "dc41bceb-d0c5-4634-a734-c01b4233a0c6"
] #[
    description: "Yacht counted as threes"
    input: #[
        dice: [3 3 3 3 3]
        category: "threes"
    ]
    expected: 15
    function: "score"
    uuid: "f6125417-5c8a-4bca-bc5b-b4b76d0d28c8"
] #[
    description: "Yacht of 3s counted as fives"
    input: #[
        dice: [3 3 3 3 3]
        category: "fives"
    ]
    expected: 0
    function: "score"
    uuid: "464fc809-96ed-46e4-acb8-d44e302e9726"
] #[
    description: "Fives"
    input: #[
        dice: [1 5 3 5 3]
        category: "fives"
    ]
    expected: 10
    function: "score"
    uuid: "d054227f-3a71-4565-a684-5c7e621ec1e9"
] #[
    description: "Sixes"
    input: #[
        dice: [2 3 4 5 6]
        category: "sixes"
    ]
    expected: 6
    function: "score"
    uuid: "e8a036e0-9d21-443a-8b5f-e15a9e19a761"
] #[
    description: "Full house two small, three big"
    input: #[
        dice: [2 2 4 4 4]
        category: "full house"
    ]
    expected: 16
    function: "score"
    uuid: "51cb26db-6b24-49af-a9ff-12f53b252eea"
] #[
    description: "Full house three small, two big"
    input: #[
        dice: [5 3 3 5 3]
        category: "full house"
    ]
    expected: 19
    function: "score"
    uuid: "1822ca9d-f235-4447-b430-2e8cfc448f0c"
] #[
    description: "Two pair is not a full house"
    input: #[
        dice: [2 2 4 4 5]
        category: "full house"
    ]
    expected: 0
    function: "score"
    uuid: "b208a3fc-db2e-4363-a936-9e9a71e69c07"
] #[
    description: "Four of a kind is not a full house"
    input: #[
        dice: [1 4 4 4 4]
        category: "full house"
    ]
    expected: 0
    function: "score"
    uuid: "b90209c3-5956-445b-8a0b-0ac8b906b1c2"
] #[
    description: "Yacht is not a full house"
    input: #[
        dice: [2 2 2 2 2]
        category: "full house"
    ]
    expected: 0
    function: "score"
    uuid: "32a3f4ee-9142-4edf-ba70-6c0f96eb4b0c"
] #[
    description: "Four of a Kind"
    input: #[
        dice: [6 6 4 6 6]
        category: "four of a kind"
    ]
    expected: 24
    function: "score"
    uuid: "b286084d-0568-4460-844a-ba79d71d79c6"
] #[
    description: "Yacht can be scored as Four of a Kind"
    input: #[
        dice: [3 3 3 3 3]
        category: "four of a kind"
    ]
    expected: 12
    function: "score"
    uuid: "f25c0c90-5397-4732-9779-b1e9b5f612ca"
] #[
    description: "Full house is not Four of a Kind"
    input: #[
        dice: [3 3 3 5 5]
        category: "four of a kind"
    ]
    expected: 0
    function: "score"
    uuid: "9f8ef4f0-72bb-401a-a871-cbad39c9cb08"
] #[
    description: "Little Straight"
    input: #[
        dice: [3 5 4 1 2]
        category: "little straight"
    ]
    expected: 30
    function: "score"
    uuid: "b4743c82-1eb8-4a65-98f7-33ad126905cd"
] #[
    description: "Little Straight as Big Straight"
    input: #[
        dice: [1 2 3 4 5]
        category: "big straight"
    ]
    expected: 0
    function: "score"
    uuid: "7ac08422-41bf-459c-8187-a38a12d080bc"
] #[
    description: "Four in order but not a little straight"
    input: #[
        dice: [1 1 2 3 4]
        category: "little straight"
    ]
    expected: 0
    function: "score"
    uuid: "97bde8f7-9058-43ea-9de7-0bc3ed6d3002"
] #[
    description: "No pairs but not a little straight"
    input: #[
        dice: [1 2 3 4 6]
        category: "little straight"
    ]
    expected: 0
    function: "score"
    uuid: "cef35ff9-9c5e-4fd2-ae95-6e4af5e95a99"
] #[
    description: {Minimum is 1, maximum is 5, but not a little straight}
    input: #[
        dice: [1 1 3 4 5]
        category: "little straight"
    ]
    expected: 0
    function: "score"
    uuid: "fd785ad2-c060-4e45-81c6-ea2bbb781b9d"
] #[
    description: "Big Straight"
    input: #[
        dice: [4 6 2 5 3]
        category: "big straight"
    ]
    expected: 30
    function: "score"
    uuid: "35bd74a6-5cf6-431a-97a3-4f713663f467"
] #[
    description: "Big Straight as little straight"
    input: #[
        dice: [6 5 4 3 2]
        category: "little straight"
    ]
    expected: 0
    function: "score"
    uuid: "87c67e1e-3e87-4f3a-a9b1-62927822b250"
] #[
    description: "No pairs but not a big straight"
    input: #[
        dice: [6 5 4 3 1]
        category: "big straight"
    ]
    expected: 0
    function: "score"
    uuid: "c1fa0a3a-40ba-4153-a42d-32bc34d2521e"
] #[
    description: "Choice"
    input: #[
        dice: [3 3 5 6 6]
        category: "choice"
    ]
    expected: 23
    function: "score"
    uuid: "207e7300-5d10-43e5-afdd-213e3ac8827d"
] #[
    description: "Yacht as choice"
    input: #[
        dice: [2 2 2 2 2]
        category: "choice"
    ]
    expected: 10
    function: "score"
    uuid: "b524c0cf-32d2-4b40-8fb3-be3500f3f135"
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
