Red [
	description: {"Darts" exercise solution for exercism platform}
	author: "dander"
]

score: function [x y][
	offset: square-root (x ** 2) + (y ** 2)
	case [
		offset > 10 [0]
		offset > 5 [1]
		offset > 1 [5]
		'bullseye [10]
	]
]