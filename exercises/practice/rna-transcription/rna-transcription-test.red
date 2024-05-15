Red [
	description: {Tests for "RNA Transcription" Exercism exercise}
	author: "loziniak"
]

#include %testlib.red

test-init/limit %rna-transcription.red 1
; test-init/limit %.meta/example.red 1						; test example solution

canonical-cases: [#[
    description: "Empty RNA sequence"
    input: #[
        dna: ""
    ]
    expected: ""
    function: "to-rna"
    uuid: "b4631f82-c98c-4a2f-90b3-c5c2b6c6f661"
] #[
    description: "RNA complement of cytosine is guanine"
    input: #[
        dna: "C"
    ]
    expected: "G"
    function: "to-rna"
    uuid: "a9558a3c-318c-4240-9256-5d5ed47005a6"
] #[
    description: "RNA complement of guanine is cytosine"
    input: #[
        dna: "G"
    ]
    expected: "C"
    function: "to-rna"
    uuid: "6eedbb5c-12cb-4c8b-9f51-f8320b4dc2e7"
] #[
    description: "RNA complement of thymine is adenine"
    input: #[
        dna: "T"
    ]
    expected: "A"
    function: "to-rna"
    uuid: "870bd3ec-8487-471d-8d9a-a25046488d3e"
] #[
    description: "RNA complement of adenine is uracil"
    input: #[
        dna: "A"
    ]
    expected: "U"
    function: "to-rna"
    uuid: "aade8964-02e1-4073-872f-42d3ffd74c5f"
] #[
    description: "RNA complement"
    input: #[
        dna: "ACGTGGTCTTAA"
    ]
    expected: "UGCACCAGAAUU"
    function: "to-rna"
    uuid: "79ed2757-f018-4f47-a1d7-34a559392dbf"
]]


foreach c-case canonical-cases [
	case-code: reduce [
		'expect c-case/expected compose [
			(to word! c-case/function) (values-of c-case/input)
		] 
	]

	test c-case/description case-code
]

test-results/print
