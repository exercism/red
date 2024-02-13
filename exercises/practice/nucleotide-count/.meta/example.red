Red [
	description: {"Nucleotide Count" exercise solution for exercism platform}
	author: "BNAndras"
]

nucleotide-counts: function [
	strand
] [
	counts: make map! [A 0 C 0 G 0 T 0]

	foreach char strand [
		switch/default char [
			#"A" [set 'counts/A 1 + get 'counts/A]
			#"C" [set 'counts/C 1 + get 'counts/C]
			#"G" [set 'counts/G 1 + get 'counts/G]
			#"T" [set 'counts/T 1 + get 'counts/T]
		] [
			cause-error 'user 'message "Invalid nucleotide in strand"
		]
	]

	counts
]

