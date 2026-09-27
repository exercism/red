Red [
	description: {Tests for "Practie Exercise" Exercism exercise}
	author: "loziniak"
]

#include %testlib.red

test-init/limit %practice-exercise.red 1
; test-init/limit %.meta/example.red 1						; test example solution

canonical-cases: []

foreach c-case canonical-cases [
	expect-code: compose [
		(to word! c-case/function) (values-of c-case/input)
	]
	case-code: reduce
		either all [
			map? c-case/expected
			string? c-case/expected/error
		] [
			['expect-error/message quote 'user expect-code c-case/expected/error]
		] [
			['expect c-case/expected expect-code]
		]

	test c-case/description case-code
]

test-results/print
