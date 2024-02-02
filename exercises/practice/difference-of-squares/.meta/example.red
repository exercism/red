Red [
	description: {"Difference of Squares" exercise solution for exercism platform}
	author: "BNAndras"
]

square-of-sum: function [
	number
] [
	result: 0
	foreach value range-inclusive number [
		result: add result value
	]
	power result 2
]

sum-of-squares: function [
	number
] [
	result: 0
	foreach value range-inclusive number  [
		result: add result power value 2
	]
	result
]

difference-of-squares: function [
	number
] [
	subtract square-of-sum number sum-of-squares number
]

range-inclusive: function [
	number
] [
	collect [repeat i number [keep i]]
]