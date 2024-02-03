Red [
	description: {Tests for Protein Translation Exercism exercise}
	author: "loziniak"
]

#include %testlib.red

test-init/limit %protein-translation.red 1
; test-init/limit %.meta/example.red 1						; test example solution

canonical-cases: [#(
    description: "Methionine RNA sequence"
    input: #(
        strand: "AUG"
    )
    expected: ["Methionine"]
    function: "proteins"
    uuid: "96d3d44f-34a2-4db4-84cd-fff523e069be"
) #(
    description: "Phenylalanine RNA sequence 1"
    input: #(
        strand: "UUU"
    )
    expected: ["Phenylalanine"]
    function: "proteins"
    uuid: "1b4c56d8-d69f-44eb-be0e-7b17546143d9"
) #(
    description: "Phenylalanine RNA sequence 2"
    input: #(
        strand: "UUC"
    )
    expected: ["Phenylalanine"]
    function: "proteins"
    uuid: "81b53646-bd57-4732-b2cb-6b1880e36d11"
) #(
    description: "Leucine RNA sequence 1"
    input: #(
        strand: "UUA"
    )
    expected: ["Leucine"]
    function: "proteins"
    uuid: "42f69d4f-19d2-4d2c-a8b0-f0ae9ee1b6b4"
) #(
    description: "Leucine RNA sequence 2"
    input: #(
        strand: "UUG"
    )
    expected: ["Leucine"]
    function: "proteins"
    uuid: "ac5edadd-08ed-40a3-b2b9-d82bb50424c4"
) #(
    description: "Serine RNA sequence 1"
    input: #(
        strand: "UCU"
    )
    expected: ["Serine"]
    function: "proteins"
    uuid: "8bc36e22-f984-44c3-9f6b-ee5d4e73f120"
) #(
    description: "Serine RNA sequence 2"
    input: #(
        strand: "UCC"
    )
    expected: ["Serine"]
    function: "proteins"
    uuid: "5c3fa5da-4268-44e5-9f4b-f016ccf90131"
) #(
    description: "Serine RNA sequence 3"
    input: #(
        strand: "UCA"
    )
    expected: ["Serine"]
    function: "proteins"
    uuid: "00579891-b594-42b4-96dc-7ff8bf519606"
) #(
    description: "Serine RNA sequence 4"
    input: #(
        strand: "UCG"
    )
    expected: ["Serine"]
    function: "proteins"
    uuid: "08c61c3b-fa34-4950-8c4a-133945570ef6"
) #(
    description: "Tyrosine RNA sequence 1"
    input: #(
        strand: "UAU"
    )
    expected: ["Tyrosine"]
    function: "proteins"
    uuid: "54e1e7d8-63c0-456d-91d2-062c72f8eef5"
) #(
    description: "Tyrosine RNA sequence 2"
    input: #(
        strand: "UAC"
    )
    expected: ["Tyrosine"]
    function: "proteins"
    uuid: "47bcfba2-9d72-46ad-bbce-22f7666b7eb1"
) #(
    description: "Cysteine RNA sequence 1"
    input: #(
        strand: "UGU"
    )
    expected: ["Cysteine"]
    function: "proteins"
    uuid: "3a691829-fe72-43a7-8c8e-1bd083163f72"
) #(
    description: "Cysteine RNA sequence 2"
    input: #(
        strand: "UGC"
    )
    expected: ["Cysteine"]
    function: "proteins"
    uuid: "1b6f8a26-ca2f-43b8-8262-3ee446021767"
) #(
    description: "Tryptophan RNA sequence"
    input: #(
        strand: "UGG"
    )
    expected: ["Tryptophan"]
    function: "proteins"
    uuid: "1e91c1eb-02c0-48a0-9e35-168ad0cb5f39"
) #(
    description: "STOP codon RNA sequence 1"
    input: #(
        strand: "UAA"
    )
    expected: []
    function: "proteins"
    uuid: "e547af0b-aeab-49c7-9f13-801773a73557"
) #(
    description: "STOP codon RNA sequence 2"
    input: #(
        strand: "UAG"
    )
    expected: []
    function: "proteins"
    uuid: "67640947-ff02-4f23-a2ef-816f8a2ba72e"
) #(
    description: "STOP codon RNA sequence 3"
    input: #(
        strand: "UGA"
    )
    expected: []
    function: "proteins"
    uuid: "9c2ad527-ebc9-4ace-808b-2b6447cb54cb"
) #(
    description: "Sequence of two protein codons translate in proteins"
    input: #(
        strand: "UUUUUU"
    )
    expected: ["Phenylalanine" "Phenylalanine"]
    function: "proteins"
    uuid: "f4d9d8ee-00a8-47bf-a1e3-1641d4428e54"
) #(
    description: "Sequence of two different protein codons translates into proteins"
    input: #(
        strand: "UUAUUG"
    )
    expected: ["Leucine" "Leucine"]
    function: "proteins"
    uuid: "dd22eef3-b4f1-4ad6-bb0b-27093c090a9d"
) #(
    description: "Translate RNA strand into correct protein list"
    input: #(
        strand: "AUGUUUUGG"
    )
    expected: ["Methionine" "Phenylalanine" "Tryptophan"]
    function: "proteins"
    uuid: "d0f295df-fb70-425c-946c-ec2ec185388e"
) #(
    description: {Translation stops if STOP codon at beginning of sequence}
    input: #(
        strand: "UAGUGG"
    )
    expected: []
    function: "proteins"
    uuid: "e30e8505-97ec-4e5f-a73e-5726a1faa1f4"
) #(
    description: {Translation stops if STOP codon at end of two-codon sequence}
    input: #(
        strand: "UGGUAG"
    )
    expected: ["Tryptophan"]
    function: "proteins"
    uuid: "5358a20b-6f4c-4893-bce4-f929001710f3"
) #(
    description: {Translation stops if STOP codon at end of three-codon sequence}
    input: #(
        strand: "AUGUUUUAA"
    )
    expected: ["Methionine" "Phenylalanine"]
    function: "proteins"
    uuid: "ba16703a-1a55-482f-bb07-b21eef5093a3"
) #(
    description: {Translation stops if STOP codon in middle of three-codon sequence}
    input: #(
        strand: "UGGUAGUGG"
    )
    expected: ["Tryptophan"]
    function: "proteins"
    uuid: "4089bb5a-d5b4-4e71-b79e-b8d1f14a2911"
) #(
    description: {Translation stops if STOP codon in middle of six-codon sequence}
    input: #(
        strand: "UGGUGUUAUUAAUGGUUU"
    )
    expected: ["Tryptophan" "Cysteine" "Tyrosine"]
    function: "proteins"
    uuid: "2c2a2a60-401f-4a80-b977-e0715b23b93d"
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
