Red [
	description: {Tests for "Eliud's Eggs" Exercism exercise}
	author: "loziniak"
]

#include %testlib.red

test-init/limit %pop-count.red 1
; test-init/limit %.meta/example.red 1						; test example solution

canonical-cases: [#(
    description: "0 eggs"
    input: #(
        number: 0
    )
    expected: 0
    function: "egg-count"
    uuid: "559e789d-07d1-4422-9004-3b699f83bca3"
) #(
    description: "1 egg"
    input: #(
        number: 16
    )
    expected: 1
    function: "egg-count"
    uuid: "97223282-f71e-490c-92f0-b3ec9e275aba"
) #(
    description: "4 eggs"
    input: #(
        number: 89
    )
    expected: 4
    function: "egg-count"
    uuid: "1f8fd18f-26e9-4144-9a0e-57cdfc4f4ff5"
) #(
    description: "13 eggs"
    input: #(
        number: 2000000000
    )
    expected: 13
    function: "egg-count"
    uuid: "0c18be92-a498-4ef2-bcbb-28ac4b06cb81"
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
