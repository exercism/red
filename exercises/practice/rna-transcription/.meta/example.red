Red [
	description: {"RNA Transcription" exercise solution for exercism platform}
	author: "BNAndras"
]

to-rna: function [
	dna
] [
 	rna: copy ""
	foreach nucleotide dna [
		switch nucleotide [
			#"G" [append rna "C"]
			#"C" [append rna "G"]
			#"T" [append rna "A"]
			#"A" [append rna "U"]
		]
	]

	rna
]
