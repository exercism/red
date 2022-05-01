Red [
	description: {"Run Length Encoding" exercise solution for exercism platform}
	author: "loziniak"
]

encode: function [
	text [string!]
	return: [string!]
] [
	encoded: copy ""
	current: none
	count: 0
	forall text [
		either current = first text [
			count: count + 1
		] [
			current: first text
			count: 1
		]
		unless any [
			none? current
			current = second text
		] [
			append encoded rejoin [
				either count > 1 [count] []
				current
			]
		]
	]
	encoded
]

decode: function [
	encoded [string!]
	return: [string!]
] [
	decoded: copy ""

	num: make bitset! [#"0" - #"9"]
	letter: make bitset! [
		#"a" - #"z"
		#"A" - #"Z"
		#" "
	]

	repetition: [
		copy n thru any num
		copy l thru letter
	]

	parse encoded [any [repetition (
		append/dup
			decoded
			l 
			either empty? n [1] [to integer! n]
	)]]

	decoded
]
