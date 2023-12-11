Red [
	description: {"Collatz Conjecture" exercise solution for exercism platform}
	author: "BNAndras"
]

steps: function [
	number
] [
	if not positive? number [
		cause-error 'user 'message "Only positive integers are allowed"		
	]

	steps: 0
	while [number <> 1] [
		number: either even? number [
			number / 2
		] [
			(number * 3) + 1
		]
		steps: steps + 1
	]

	steps
]

