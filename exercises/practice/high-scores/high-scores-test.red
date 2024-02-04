Red [
	description: {Tests for "High Scores" Exercism exercise}
	author: "loziniak"
]

#include %testlib.red

test-init/limit %high-scores.red 1
; test-init/limit	%.meta/example.red 1						; test example solution

canonical-cases: [#(
    description: "List of scores"
    input: #(
        scores: [30 50 20 70]
    )
    expected: [30 50 20 70]
    function: "scores"
    uuid: "1035eb93-2208-4c22-bab8-fef06769a73c"
) #(
    description: "Latest score"
    input: #(
        scores: [100 0 90 30]
    )
    expected: 30
    function: "latest"
    uuid: "6aa5dbf5-78fa-4375-b22c-ffaa989732d2"
) #(
    description: "Personal best"
    input: #(
        scores: [40 100 70]
    )
    expected: 100
    function: "personal-best"
    uuid: "b661a2e1-aebf-4f50-9139-0fb817dd12c6"
) #(
    description: "Personal top three from a list of scores"
    input: #(
        scores: [10 30 90 30 100 20 10 0 30 40 40 70 70]
    )
    expected: [100 90 70]
    function: "personal-top-three"
    uuid: "3d996a97-c81c-4642-9afc-80b80dc14015"
) #(
    description: "Personal top highest to lowest"
    input: #(
        scores: [20 10 30]
    )
    expected: [30 20 10]
    function: "personal-top-three"
    uuid: "1084ecb5-3eb4-46fe-a816-e40331a4e83a"
) #(
    description: "Personal top when there is a tie"
    input: #(
        scores: [40 20 40 30]
    )
    expected: [40 40 30]
    function: "personal-top-three"
    uuid: "e6465b6b-5a11-4936-bfe3-35241c4f4f16"
) #(
    description: "Personal top when there are less than 3"
    input: #(
        scores: [30 70]
    )
    expected: [70 30]
    function: "personal-top-three"
    uuid: "f73b02af-c8fd-41c9-91b9-c86eaa86bce2"
) #(
    description: "Personal top when there is only one"
    input: #(
        scores: [40]
    )
    expected: [40]
    function: "personal-top-three"
    uuid: "16608eae-f60f-4a88-800e-aabce5df2865"
)]


foreach c-case canonical-cases [
	case-code: reduce [
		'expect c-case/expected compose [
			(to word! c-case/function) (values-of c-case/input)
		] 
	]

	test c-case/description case-code
]


test "Latest score after personal top scores" [
	scoresList: [70 50 20 30]

	personal-top-three scoresList
	
	expect 30 [
		latest scoresList
	]
]

test "Scores after personal top scores" [
	scoresList: [70 50 20 30]

	personal-top-three scoresList
	
	expect [70 50 20 30] [
		scores scoresList
	]
]

test "Latest score after personal best" [
	scoresList: [20 70 15 25 30]

	personal-best scoresList
	
	expect 30 [
		latest scoresList
	]
]

test "Scores after personal best" [
	scoresList: [20 70 15 25 30]

	personal-best scoresList
	
	expect [20 70 15 25 30] [
		scores scoresList
	]
]

test-results/print
