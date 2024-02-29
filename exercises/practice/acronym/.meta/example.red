Red [
	description: {"Acronym" exercise solution for exercism platform}
	author: "BNAndras"
]

abbreviate: function [
	phrase
] [
	abbreviation: ""
	words: split replace/all replace/all phrase "-" " " "_" "" " "
	foreach word words [
		letter: either empty? word [""] [first word]
		append abbreviation letter
	] 
	
	uppercase abbreviation
]
 
