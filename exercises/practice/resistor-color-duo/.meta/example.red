Red [
	description: {"Resistor Color Duo" exercise solution for exercism platform}
	author: "loziniak"
]

colors: ["black" "brown" "red" "orange" "yellow" "green" "blue" "violet" "grey" "white"]

; taken from resistor-color
color-code: function [
	color [string!]
	return: [integer!]
] [
	unless none? c: find colors color [
		(index? c) - 1
	]
]

value: function [
	"Returns two-digit number representation of first two resistor's color bands."
	colors [block!]
	return: [integer!]
] [
	10 * (color-code colors/1) + (color-code colors/2)
]

