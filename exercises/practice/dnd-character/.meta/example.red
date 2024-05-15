Red [
	description: {"D&D Character" exercise solution for exercism platform}
	author: "BNAndras"
]


character: object [
	strength: 0
	dexterity: 0
	constitution: 0
	intelligence: 0
	wisdom: 0
	charisma: 0
	hitpoints: 0
]

modifier: function [
	score
] [
	to integer! round/floor divide score - 10.0 2
]

ability: function [] [
	rolls: copy []
	repeat i 4 [
		append/only rolls random 6
	]
	sum next sort rolls
]

new-character: function [] [
	constitution-score: ability()
	make character [
		strength: ability
		dexterity: ability
		constitution: constitution-score
		intelligence: ability
		wisdom: ability
		charisma: ability()
		hitpoints: 10 + modifier constitution-score
	]
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
