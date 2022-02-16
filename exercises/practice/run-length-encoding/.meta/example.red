Red [
	description: {"Run Length Encoding" exercise solution for exercism platform}
	author: "kickass"
]

encode: function [
	text [string!]
	return: [string!]
] [
	out: copy ""
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
			append out rejoin [
				either count > 1 [count] []
				current
			]
		]
	]
	out
]

decode: function [
	encoding [string!]
	return: [string!]
] [
	cause-error 'user 'message ["You need to implement this function."]
]
