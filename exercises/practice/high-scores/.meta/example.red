Red [
	description: {"High Scores" exercise solution for exercism platform}
	author: "loziniak"
]

scores: function [
	scores [block!]
	return: [block!]
] [
	scores
]

latest: function [
	scores [block!]
	return: [integer!]
] [
	last scores
]

personal-best: function [
	scores [block!]
	return: [integer!]
] [
	best: first scores
	foreach score next scores [
		if best < score [
			best: score
		]
	]
	best
]

personal-top-three: function [
	scores [block!]
	return: [block!]
] [
	head remove/part
		at
			sort/reverse  copy scores
			4
		length? scores
]
