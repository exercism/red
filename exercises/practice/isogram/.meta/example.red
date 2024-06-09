Red [
	description: {"Isogram" exercise solution for exercism platform}
	author: "BNAndras"
]

alphabet: "abcdefghijklmnopqrstuvwxyz"

is-isogram: function [
	phrase
] [
	letters: []
	phrase: lowercase phrase

	letters: []
	foreach char phrase [
		if (to-logic find alphabet char) [
			append letters char
		]
	]

	equal? length? letters length? unique letters
]

