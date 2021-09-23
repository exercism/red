Red [
	description: {"Resistor Color Trio" exercise solution for exercism platform}
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

; taken from resistor-color-duo
main-value: function [
	"Two-digit number representation of first two resistor's color bands"
	colors [block!]
	return: [integer!]
] [
	10 * (color-code colors/1) + (color-code colors/2)
]

label: function [
	"Full representation of three resistor's color bands"
	colors [block!]
	return: [map!]
] [
	main: main-value colors
	zeros: color-code colors/3
	if 0 = (main % 10) [
		main: main / 10
		zeros: zeros + 1
	]

	unit: copy "ohms"
	case [
		9 <= zeros [
			insert unit "giga"
			zeros: zeros - 9
		]
		6 <= zeros [
			insert unit "mega"
			zeros: zeros - 6
		]
		3 <= zeros [
			insert unit "kilo"
			zeros: zeros - 3
		]
	]

	value: 10 ** zeros * main

	make map! compose [
		value: (value)
		unit: (unit)
	]
]
