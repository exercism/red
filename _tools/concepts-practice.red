Red [
	description: {Counts and prints exercises unlocked by each concept, and exercises that practice the concept}
	author: "loziniak"
]

config: load %../config.json

concepts-practice: #[]
concepts-unlock: #[]

append-concept: function [
	type [word!]
	name [word! string!]
	exercise [map!]
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
	append c exercise
	
]

print-concepts: function [
	c [map!]
] [
	foreach key keys-of c [
		difficulties: copy ""
		names: copy []
		foreach exercise c/(key) [
			append difficulties to string! exercise/difficulty
			append names to string! exercise/slug
		]
		sort difficulties

		print [
			head insert
				pad/left  copy key  (30 - length? difficulties)
				difficulties
			"-"
			names
		]
	]
]

foreach exercise config/exercises/practice [
	foreach concept exercise/practices [
		append-concept 'practice concept exercise
	]
	foreach concept exercise/prerequisites [
		append-concept 'unlocks concept exercise
	]
]

print "^/^/PRACTICE:^/"
print-concepts concepts-practice

print "^/^/UNLOCKED:^/"
print-concepts concepts-unlock
