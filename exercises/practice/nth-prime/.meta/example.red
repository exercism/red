Red [
	description: {"Nth Prime" exercise solution for exercism platform}
	author: "BNAndras"
]

prime: function [
	number
] [
	if number == 0 [
		cause-error 'user 'message "there is no zeroth prime"
	]

	if number == 1 [return 2]


	tally: 1
	candidate: 1
	while [tally < number] [
		candidate: candidate + 2
	
		if prime? candidate [
			tally: tally + 1
		]
	]
	candidate
]

prime?: function [
	number
] [
	if number <= 1 [return false]
	if number == 2 [return true]
	if number % 2 == 0 [return false]

	prime: 3
	while [prime * prime <= number] [
		if number % prime == 0 [return false]
		prime: prime + 2
	]
	true
]
