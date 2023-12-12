Red [
	description: {Tests for "Scrabble Score" Exercism exercise}
	author: "loziniak"
]

#include %testlib.red

test-init/limit %scrabble-score.red 1
; test-init/limit %.meta/example.red 1						; test example solution

canonical-cases: [#(
    description: "lowercase letter"
    input: #(
        word: "a"
    )
    expected: 1
    function: "score"
    uuid: "f46cda29-1ca5-4ef2-bd45-388a767e3db2"
) #(
    description: "uppercase letter"
    input: #(
        word: "A"
    )
    expected: 1
    function: "score"
    uuid: "f7794b49-f13e-45d1-a933-4e48459b2201"
) #(
    description: "valuable letter"
    input: #(
        word: "f"
    )
    expected: 4
    function: "score"
    uuid: "eaba9c76-f9fa-49c9-a1b0-d1ba3a5b31fa"
) #(
    description: "short word"
    input: #(
        word: "at"
    )
    expected: 2
    function: "score"
    uuid: "f3c8c94e-bb48-4da2-b09f-e832e103151e"
) #(
    description: "short, valuable word"
    input: #(
        word: "zoo"
    )
    expected: 12
    function: "score"
    uuid: "71e3d8fa-900d-4548-930e-68e7067c4615"
) #(
    description: "medium word"
    input: #(
        word: "street"
    )
    expected: 6
    function: "score"
    uuid: "d3088ad9-570c-4b51-8764-c75d5a430e99"
) #(
    description: "medium, valuable word"
    input: #(
        word: "quirky"
    )
    expected: 22
    function: "score"
    uuid: "fa20c572-ad86-400a-8511-64512daac352"
) #(
    description: "long, mixed-case word"
    input: #(
        word: "OxyphenButazone"
    )
    expected: 41
    function: "score"
    uuid: "9336f0ba-9c2b-4fa0-bd1c-2e2d328cf967"
) #(
    description: "english-like word"
    input: #(
        word: "pinata"
    )
    expected: 8
    function: "score"
    uuid: "1e34e2c3-e444-4ea7-b598-3c2b46fd2c10"
) #(
    description: "empty input"
    input: #(
        word: ""
    )
    expected: 0
    function: "score"
    uuid: "4efe3169-b3b6-4334-8bae-ff4ef24a7e4f"
) #(
    description: "entire alphabet available"
    input: #(
        word: "abcdefghijklmnopqrstuvwxyz"
    )
    expected: 87
    function: "score"
    uuid: "3b305c1c-f260-4e15-a5b5-cb7d3ea7c3d7"
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
