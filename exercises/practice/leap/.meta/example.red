Red [
	description: {"Leap" exercise solution for exercism platform}
	author: "BNAndras"
]

leap: function [
	year
] [
	divisible?: func [n] [zero? year // n]
		to logic! any [all [divisible? 4 not divisible? 100] divisible? 400]
]

