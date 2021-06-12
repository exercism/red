Red [
	description: {"Two-fer" exercise solution for exercism platform}
	author: "loziniak"
]

two-fer: function [
	name [string! none!]
] [
	rejoin [
		"One for "
		either name = none [
			"you"
		] [
			name
		]
		", one for me."
	]
]
