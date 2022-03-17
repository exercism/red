Red [
	description: {Tests for "Reverse String" Exercism exercise}
	author: "loziniak"
]

#include %testlib.red

test-init/limit %reverse-string.red 1
; test-init/limit %.meta/example.red 1						; test example solution

canonical-cases: [
	#(
		description: "an empty string"
		input: #(value: "")
		expected: ""
		function: "reverse"
		uuid: "c3b7d806-dced-49ee-8543-933fd1719b1c"
	)
	#(
		description: "a word"
		input: #(value: "robot")
		expected: "tobor"
		function: "reverse"
		uuid: "01ebf55b-bebb-414e-9dec-06f7bb0bee3c"
	)
	#(
		description: "a capitalized word"
		input: #(value: "Ramen")
		expected: "nemaR"
		function: "reverse"
		uuid: "0f7c07e4-efd1-4aaa-a07a-90b49ce0b746"
	)
	#(
		description: "a sentence with punctuation"
		input: #(value: "I'm hungry!")
		expected: "!yrgnuh m'I"
		function: "reverse"
		uuid: "71854b9c-f200-4469-9f5c-1e8e5eff5614"
	)
	#(
		description: "a palindrome"
		input: #(value: "racecar")
		expected: "racecar"
		function: "reverse"
		uuid: "1f8ed2f3-56f3-459b-8f3e-6d8d654a1f6c"
	)
	#(
		description: "an even-sized word"
		input: #(value: "drawer")
		expected: "reward"
		function: "reverse"
		uuid: "b9e7dec1-c6df-40bd-9fa3-cd7ded010c4c"
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
