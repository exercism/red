Red [
	description: {Counts and prints exercises unlocked by each concept, and exercises that practice the concept}
	author: "loziniak"
]

config: load %../config.json

concepts-practice: #()
concepts-unlock: #()

append-concept: function [
	type [word!]
	name [word! string!]
	slug [string!]
] [
	name: to string! name
	
	type-concepts: either type = 'practice [
		concepts-practice
	] [
		concepts-unlock
	]
	c: type-concepts/(name)
	if none? c [
		c: type-concepts/(name): copy []
	]
	append c slug
	
]

print-concepts: function [
	c [map!]
] [
	foreach key keys-of c [
		print [
			pad/left/with
				pad/left copy key (30 - length? c/(key))
				30
				#"*"
			" "
			c/(key)
		]
	]
]

foreach exercise config/exercises/practice [
	foreach concept exercise/practices [
		append-concept 'practice concept exercise/slug
	]
	foreach concept exercise/prerequisites [
		append-concept 'unlocks concept exercise/slug
	]
]

print "^/^/PRACTICE:^/"
print-concepts concepts-practice

print "^/^/UNLOCKED:^/"
print-concepts concepts-unlock
