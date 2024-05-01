Red [
	description: {Tests for "Pangram" Exercism exercise}
	author: "loziniak"
]

#include %testlib.red

test-init/limit %pangram.red 1
; test-init/limit %.meta/example.red 1						; test example solution

canonical-cases: [#[
    description: "empty sentence"
    input: #[
        sentence: ""
    ]
    expected: false
    function: "is-pangram"
    uuid: "64f61791-508e-4f5c-83ab-05de042b0149"
] #[
    description: "perfect lower case"
    input: #[
        sentence: "abcdefghijklmnopqrstuvwxyz"
    ]
    expected: true
    function: "is-pangram"
    uuid: "74858f80-4a4d-478b-8a5e-c6477e4e4e84"
] #[
    description: "only lower case"
    input: #[
        sentence: "the quick brown fox jumps over the lazy dog"
    ]
    expected: true
    function: "is-pangram"
    uuid: "61288860-35ca-4abe-ba08-f5df76ecbdcd"
] #[
    description: "missing the letter 'x'"
    input: #[
        sentence: {a quick movement of the enemy will jeopardize five gunboats}
    ]
    expected: false
    function: "is-pangram"
    uuid: "6564267d-8ac5-4d29-baf2-e7d2e304a743"
] #[
    description: "missing the letter 'h'"
    input: #[
        sentence: "five boxing wizards jump quickly at it"
    ]
    expected: false
    function: "is-pangram"
    uuid: "c79af1be-d715-4cdb-a5f2-b2fa3e7e0de0"
] #[
    description: "with underscores"
    input: #[
        sentence: "the_quick_brown_fox_jumps_over_the_lazy_dog"
    ]
    expected: true
    function: "is-pangram"
    uuid: "d835ec38-bc8f-48e4-9e36-eb232427b1df"
] #[
    description: "with numbers"
    input: #[
        sentence: "the 1 quick brown fox jumps over the 2 lazy dogs"
    ]
    expected: true
    function: "is-pangram"
    uuid: "8cc1e080-a178-4494-b4b3-06982c9be2a8"
] #[
    description: "missing letters replaced by numbers"
    input: #[
        sentence: "7h3 qu1ck brown fox jumps ov3r 7h3 lazy dog"
    ]
    expected: false
    function: "is-pangram"
    uuid: "bed96b1c-ff95-45b8-9731-fdbdcb6ede9a"
] #[
    description: "mixed case and punctuation"
    input: #[
        sentence: {"Five quacking Zephyrs jolt my wax bed."}
    ]
    expected: true
    function: "is-pangram"
    uuid: "938bd5d8-ade5-40e2-a2d9-55a338a01030"
] #[
    description: {a-m and A-M are 26 different characters but not a pangram}
    input: #[
        sentence: "abcdefghijklm ABCDEFGHIJKLM"
    ]
    expected: false
    function: "is-pangram"
    uuid: "7138e389-83e4-4c6e-8413-1e40a0076951"
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
