Red [
	description: {Tests for "Collatz Conjecture" Exercism exercise}
	author: "loziniak"
]

#include %testlib.red

test-init/limit %collatz-conjecture.red 1
; test-init/limit %.meta/example.red 1						; test example solution

canonical-cases: [#(
    description: "zero steps for one"
    input: #(
        number: 1
    )
    expected: 0
    function: "steps"
    uuid: "540a3d51-e7a6-47a5-92a3-4ad1838f0bfd"
) #(
    description: "divide if even"
    input: #(
        number: 16
    )
    expected: 4
    function: "steps"
    uuid: "3d76a0a6-ea84-444a-821a-f7857c2c1859"
) #(
    description: "even and odd steps"
    input: #(
        number: 12
    )
    expected: 9
    function: "steps"
    uuid: "754dea81-123c-429e-b8bc-db20b05a87b9"
) #(
    description: "large number of even and odd steps"
    input: #(
        number: 1000000
    )
    expected: 152
    function: "steps"
    uuid: "ecfd0210-6f85-44f6-8280-f65534892ff6"
) #(
    description: "zero is an error"
    input: #(
        number: 0
    )
    expected: #(
        error: "Only positive integers are allowed"
    )
    function: "steps"
    uuid: "2187673d-77d6-4543-975e-66df6c50e2da"
) #(
    description: "negative value is an error"
    input: #(
        number: -15
    )
    expected: #(
        error: "Only positive integers are allowed"
    )
    function: "steps"
    uuid: "ec11f479-56bc-47fd-a434-bcd7a31a7a2e"
)]


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
