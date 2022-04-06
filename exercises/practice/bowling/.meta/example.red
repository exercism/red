Red [
	description: {"Bowling" exercise solution for exercism platform}
	author: "loziniak"
]

running-total: 0

score: function [
	return: [integer!]
] [
	running-total
]

roll: function [
	pins [integer!]
	/extern running-total
] [
	running-total: running-total + pins
]
