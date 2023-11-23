Red [
	description: {"Grains" exercise solution for exercism platform}
	author: "BNAndras"
]

square: function [
	"Returns the number of grains on a given square"
	square [integer!]
	return: [integer!]
] [
	if (square < 1) or (square > 64) [
		cause-error 'user 'message "square must be between 1 and 64"
	]

	power 2 (square - 1)
]

total: function [
	"Returns the total number of grains on a chessboard"
	return: [integer!]
] [
	(power 2 64) - 1
]

