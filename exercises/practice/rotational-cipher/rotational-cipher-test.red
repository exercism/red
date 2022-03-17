Red [
	description: {Tests for Rotational Cipher Exercism exercise}
	author: "loziniak"
]

#include %testlib.red

test-init/limit %rotational-cipher.red 1
; test-init/limit %.meta/example.red 1						; test example solution

canonical-cases: [#(
    description: "rotate a by 0, same output as input"
    input: #(
        text: "a"
        shiftKey: 0
    )
    expected: "a"
    function: "rotate"
    uuid: "74e58a38-e484-43f1-9466-877a7515e10f"
) #(
    description: "rotate a by 1"
    input: #(
        text: "a"
        shiftKey: 1
    )
    expected: "b"
    function: "rotate"
    uuid: "7ee352c6-e6b0-4930-b903-d09943ecb8f5"
) #(
    description: "rotate a by 26, same output as input"
    input: #(
        text: "a"
        shiftKey: 26
    )
    expected: "a"
    function: "rotate"
    uuid: "edf0a733-4231-4594-a5ee-46a4009ad764"
) #(
    description: "rotate m by 13"
    input: #(
        text: "m"
        shiftKey: 13
    )
    expected: "z"
    function: "rotate"
    uuid: "e3e82cb9-2a5b-403f-9931-e43213879300"
) #(
    description: "rotate n by 13 with wrap around alphabet"
    input: #(
        text: "n"
        shiftKey: 13
    )
    expected: "a"
    function: "rotate"
    uuid: "19f9eb78-e2ad-4da4-8fe3-9291d47c1709"
) #(
    description: "rotate capital letters"
    input: #(
        text: "OMG"
        shiftKey: 5
    )
    expected: "TRL"
    function: "rotate"
    uuid: "a116aef4-225b-4da9-884f-e8023ca6408a"
) #(
    description: "rotate spaces"
    input: #(
        text: "O M G"
        shiftKey: 5
    )
    expected: "T R L"
    function: "rotate"
    uuid: "71b541bb-819c-4dc6-a9c3-132ef9bb737b"
) #(
    description: "rotate numbers"
    input: #(
        text: "Testing 1 2 3 testing"
        shiftKey: 4
    )
    expected: "Xiwxmrk 1 2 3 xiwxmrk"
    function: "rotate"
    uuid: "ef32601d-e9ef-4b29-b2b5-8971392282e6"
) #(
    description: "rotate punctuation"
    input: #(
        text: "Let's eat, Grandma!"
        shiftKey: 21
    )
    expected: "Gzo'n zvo, Bmviyhv!"
    function: "rotate"
    uuid: "32dd74f6-db2b-41a6-b02c-82eb4f93e549"
) #(
    description: "rotate all letters"
    input: #(
        text: "The quick brown fox jumps over the lazy dog."
        shiftKey: 13
    )
    expected: "Gur dhvpx oebja sbk whzcf bire gur ynml qbt."
    function: "rotate"
    uuid: "9fb93fe6-42b0-46e6-9ec1-0bf0a062d8c9"
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
