Red [
	description: {"D&D Character" exercise solution for exercism platform}
	author: "" ; you can write your name here, in quotes
]

modifier: function [
	score
] [
	cause-error 'user 'message "You need to implement modifier function."
]

ability: function [] [
	cause-error 'user 'message "You need to implement ability function."
]

new-character: function [] [
	cause-error 'user 'message "You need to implement character function."
]

; Don't edit the following functions used by the test suite

test-ability: function [] [
	is-valid ability
]

is-valid: function [
	score
] [
	(score >= 3) and (score <= 18)
]

test-random-character-valid: function [] [
	char: new-character

	(is-valid char/strength)
	and (is-valid char/dexterity)
	and (is-valid char/constitution)
	and (is-valid char/intelligence)
	and (is-valid char/wisdom)
	and (char/hitpoints == (10 + modifier char/constitution))
]
