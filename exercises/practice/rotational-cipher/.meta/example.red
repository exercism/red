Red [
	description: {"Rotational Cipher" exercise solution for exercism platform}
	author: "loziniak"
]

rotation-code: function [start [char!]] [
	compose/deep [
		all [c >= (start) c < (start + 26)] [
			c: c + shiftKey
			if c >= (start + 26) [c: c - 26]
			change text c
		]
	]
]

rotate: function [
	text
	shiftKey
] compose/deep [
	forall text [
		c: first text
		case [
			(rotation-code #"A")
			(rotation-code #"a")
		]
	]
	text
]
