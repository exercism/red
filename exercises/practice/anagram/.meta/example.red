Red [
	description: {"Anagram" exercise solution for exercism platform}
	author: "BNAndras"
]

find-anagrams: function [
	subject
	candidates
] [

	matches: copy []
	subject-lowered: lowercase copy subject
	subject-letters: sort copy subject-lowered

	foreach candidate candidates [
		candidate-lowered: lowercase copy candidate
		candidate-letters: sort copy candidate-lowered
		if ((subject-lowered <> candidate-lowered) and (subject-letters = candidate-letters)) [
			append matches candidate
		]
	]

	matches
]
