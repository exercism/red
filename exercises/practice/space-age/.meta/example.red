Red [
	description: {"Space Age" exercise solution for exercism platform}
	author: "loziniak"
]

seconds-in-earth-year: 31557600

earth-year-factors: [
	"Mercury" 0.2408467
	"Venus" 0.61519726
	"Earth" 1.0
	"Mars" 1.8808158
	"Jupiter" 11.862615
	"Saturn" 29.447498
	"Uranus" 84.016846
	"Neptune" 164.79132
]

age: function [
	"Computes how many years pass on a planet during given seconds count"
	planet [string!]
	seconds [integer!]
	return: [float!]
] [
	round/to
		seconds / seconds-in-earth-year / select earth-year-factors planet
		0.01
]
