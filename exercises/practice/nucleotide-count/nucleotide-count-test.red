Red [
	description: {Tests for "Nucleotide Count" Exercism exercise}
	author: "loziniak"
]

#include %testlib.red

test-init/limit %nucleotide-count.red 1
; test-init/limit %.meta/example.red 1						; test example solution

canonical-cases: [#(
    description: "empty strand"
    input: #(
        strand: ""
    )
    expected: #(
        A: 0
        C: 0
        G: 0
        T: 0
    )
    function: "nucleotide-counts"
    uuid: "3e5c30a8-87e2-4845-a815-a49671ade970"
) #(
    description: {can count one nucleotide in single-character input}
    input: #(
        strand: "G"
    )
    expected: #(
        A: 0
        C: 0
        G: 1
        T: 0
    )
    function: "nucleotide-counts"
    uuid: "a0ea42a6-06d9-4ac6-828c-7ccaccf98fec"
) #(
    description: "strand with repeated nucleotide"
    input: #(
        strand: "GGGGGGG"
    )
    expected: #(
        A: 0
        C: 0
        G: 7
        T: 0
    )
    function: "nucleotide-counts"
    uuid: "eca0d565-ed8c-43e7-9033-6cefbf5115b5"
) #(
    description: "strand with multiple nucleotides"
    input: #(
        strand: {AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC}
    )
    expected: #(
        A: 20
        C: 12
        G: 17
        T: 21
    )
    function: "nucleotide-counts"
    uuid: "40a45eac-c83f-4740-901a-20b22d15a39f"
) #(
    description: "strand with invalid nucleotides"
    input: #(
        strand: "AGXXACT"
    )
    expected: #(
        error: "Invalid nucleotide in strand"
    )
    function: "nucleotide-counts"
    uuid: "b4c47851-ee9e-4b0a-be70-a86e343bd851"
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
