Red [
	description: {Tests for "Square Root" Exercism exercise}
	author: "loziniak"
]

#include %testlib.red

test-init/limit %square-root.red 1
; test-init/limit %.meta/example.red 1						; test example solution

canonical-cases: [#(
    description: "root of 1"
    input: #(
        radicand: 1
    )
    expected: 1
    function: "square-root"
    uuid: "9b748478-7b0a-490c-b87a-609dacf631fd"
) #(
    description: "root of 4"
    input: #(
        radicand: 4
    )
    expected: 2
    function: "square-root"
    uuid: "7d3aa9ba-9ac6-4e93-a18b-2e8b477139bb"
) #(
    description: "root of 25"
    input: #(
        radicand: 25
    )
    expected: 5
    function: "square-root"
    uuid: "6624aabf-3659-4ae0-a1c8-25ae7f33c6ef"
) #(
    description: "root of 81"
    input: #(
        radicand: 81
    )
    expected: 9
    function: "square-root"
    uuid: "93beac69-265e-4429-abb1-94506b431f81"
) #(
    description: "root of 196"
    input: #(
        radicand: 196
    )
    expected: 14
    function: "square-root"
    uuid: "fbddfeda-8c4f-4bc4-87ca-6991af35360e"
) #(
    description: "root of 65025"
    input: #(
        radicand: 65025
    )
    expected: 255
    function: "square-root"
    uuid: "c03d0532-8368-4734-a8e0-f96a9eb7fc1d"
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
