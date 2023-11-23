Red [
	description: {"Eliud's Eggs" exercise solution for exercism platform}
	author: "BNAndras"
]

egg-count: function [
	number [integer!]
] [
	counter: 0
	while [number <> 0][
		if (modulo number 2) = 1 [
			counter: add counter 1
		]

		number: round/down (divide number 2)
	]

	counter
]

