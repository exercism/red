Red [
	description: {Tests for "Two-fer" Exercism exercise}
	author: "loziniak"
]

#include %testlib.red

test-init/limit %two-fer.red 1
; test-init/limit %.meta/example.red 1						; test example solution

canonical-cases: [
	#(
		description: "no name given"
		input: #(name: none)
		expected: "One for you, one for me."
		function: "two-fer"
		uuid: "1cf3e15a-a3d7-4a87-aeb3-ba1b43bc8dce"
	)
	#(
		description: "a name given"
		input: #(name: "Alice")
		expected: "One for Alice, one for me."
		function: "two-fer"
		uuid: "b4c6dbb8-b4fb-42c2-bafd-10785abe7709"
	)
	#(
		description: "another name given"
		input: #(name: "Bob")
		expected: "One for Bob, one for me."
		function: "two-fer"
		uuid: "3549048d-1a6e-4653-9a79-b0bda163e8d5"
	)
]


foreach c-case canonical-cases [
	case-code: reduce [
		'expect c-case/expected compose [
			(to word! c-case/function) (values-of c-case/input)
		] 
	]

	test c-case/description case-code
]

test-results/print
