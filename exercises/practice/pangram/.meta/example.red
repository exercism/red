Red [
	description: {"Pangram" exercise solution for exercism platform}
	author: "BNAndras"
]

is-pangram: function [
	sentence
] [
	foreach letter "abcdefghijklmnopqrstuvwxyz" [
		if not find sentence letter [
			return false
		]
	]

	true
]

