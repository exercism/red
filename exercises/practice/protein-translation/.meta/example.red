Red [
	description: {"Protein Translation" exercise solution for exercism platform}
	author: "loziniak"
]

proteins: function [
	"Translate RNA sequences into proteins"
	strand [string!]
	return: [block!]
] [
	codons: [
		"AUG" "Methionine"
		"UUU" "Phenylalanine"
		"UUC" "Phenylalanine"
		"UUA" "Leucine"
		"UUG" "Leucine"
		"UCU" "Serine"
		"UCC" "Serine"
		"UCA" "Serine"
		"UCG" "Serine"
		"UAU" "Tyrosine"
		"UAC" "Tyrosine"
		"UGU" "Cysteine"
		"UGC" "Cysteine"
		"UGG" "Tryptophan"
		"UAA" "STOP"
		"UAG" "STOP"
		"UGA" "STOP"
	]

	prots: copy []
	until [
		codon: take/part strand 3
		protein: codons/(codon)

		either protein = "STOP" [
			true
		] [
			append prots protein
			tail? strand
		]
	]
	prots
]
