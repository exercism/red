Red [
	description: {"Resistor Color" exercise solution for exercism platform}
	author: "loziniak"
]

color-code: function [
	color [string!]
	return: [integer!]
] [
	unless none? c: find colors color [
		(index? c) - 1
	]
]

colors: function [] [
	["black" "brown" "red" "orange" "yellow" "green" "blue" "violet" "grey" "white"]
]
