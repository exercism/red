Red [
	description: {"Armstrong Numbers" exercise solution for exercism platform}
	author: "BNAndras"
]

is-armstrong-number: function [
	number
] [
	working: 0
	digits: to-string number
	foreach digit digits [
		working: working + power to-integer form digit length? digits
	]
	working == number
]

