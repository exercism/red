Red [
	description: {Tests for "Practie Exercise" Exercism exercise}
	author: "loziniak"
]

#include %testlib.red

test-init/limit %practice-exercise.red 1
; test-init/limit %.meta/example.red 1						; test example solution

canonical-cases: []

foreach c-case canonical-cases [
	case-code: reduce [
		'expect c-case/expected compose [
			(to word! c-case/function) (values-of c-case/input)
		] 
	]

	test c-case/description case-code
]
