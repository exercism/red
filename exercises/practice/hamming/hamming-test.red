Red [
	description: {Tests for "Hamming" Exercism exercise}
	author: "loziniak"
]

#include %testlib.red

test-init/limit %hamming.red 1
; test-init/limit %.meta/example.red 1						; test example solution

canonical-cases: [#(
    description: "empty strands"
    input: #(
        strand1: ""
        strand2: ""
    )
    expected: 0
    function: "distance"
    uuid: "f6dcb64f-03b0-4b60-81b1-3c9dbf47e887"
) #(
    description: "single letter identical strands"
    input: #(
        strand1: "A"
        strand2: "A"
    )
    expected: 0
    function: "distance"
    uuid: "54681314-eee2-439a-9db0-b0636c656156"
) #(
    description: "single letter different strands"
    input: #(
        strand1: "G"
        strand2: "T"
    )
    expected: 1
    function: "distance"
    uuid: "294479a3-a4c8-478f-8d63-6209815a827b"
) #(
    description: "long identical strands"
    input: #(
        strand1: "GGACTGAAATCTG"
        strand2: "GGACTGAAATCTG"
    )
    expected: 0
    function: "distance"
    uuid: "9aed5f34-5693-4344-9b31-40c692fb5592"
) #(
    description: "long different strands"
    input: #(
        strand1: "GGACGGATTCTG"
        strand2: "AGGACGGATTCT"
    )
    expected: 9
    function: "distance"
    uuid: "cd2273a5-c576-46c8-a52b-dee251c3e6e5"
) #(
    description: "disallow first strand longer"
    input: #(
        strand1: "AATG"
        strand2: "AAA"
    )
    expected: #(
        error: "strands must be of equal length"
    )
    function: "distance"
    uuid: "b9228bb1-465f-4141-b40f-1f99812de5a8"
) #(
    description: "disallow second strand longer"
    input: #(
        strand1: "ATA"
        strand2: "AGTG"
    )
    expected: #(
        error: "strands must be of equal length"
    )
    function: "distance"
    uuid: "dab38838-26bb-4fff-acbe-3b0a9bfeba2d"
) #(
    description: "disallow empty first strand"
    input: #(
        strand1: ""
        strand2: "G"
    )
    expected: #(
        error: "strands must be of equal length"
    )
    function: "distance"
    uuid: "b764d47c-83ff-4de2-ab10-6cfe4b15c0f3"
) #(
    description: "disallow empty second strand"
    input: #(
        strand1: "G"
        strand2: ""
    )
    expected: #(
        error: "strands must be of equal length"
    )
    function: "distance"
    uuid: "9ab9262f-3521-4191-81f5-0ed184a5aa89"
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
