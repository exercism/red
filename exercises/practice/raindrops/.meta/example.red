Red [
	description: {"Raindrops" exercise solution for exercism platform}
	author: "loziniak"
]

convert: function [
	"Generates a raindrop sound transcription of a number"
	number [integer!]
	return: [string!]
] [
	sound: copy ""
	case/all [
		number % 3 = 0 [append sound "Pling"]
		number % 5 = 0 [append sound "Plang"]
		number % 7 = 0 [append sound "Plong"]
		empty? sound [append  sound  to string! number]
	]
	sound
]
