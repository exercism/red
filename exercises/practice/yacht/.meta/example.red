Red [
	description: {"Yacht" exercise solution for exercism platform}
	author: "BNAndras"
]

score: function [
	dice
	category
] [
	value: switch/default category [
		"yacht" 			[if equal? 1 length? unique dice [50]]
		"ones"				[1 * count dice 1]
		"twos"				[2 * count dice 2]
		"threes"			[3 * count dice 3]
		"fours"				[4 * count dice 4]
		"fives" 			[5 * count dice 5]
		"sixes" 			[6 * count dice 6]
		"full house"		[
			counts: #[]
			foreach die dice [
				if none? find counts die [
					put counts die 0
				]
				put counts die add 1 select counts die
			]
			if [2 3] = sort values-of counts [sum dice]
		 ]
		"four of a kind"	[
			case [
				lesser-or-equal? 4 count dice 1 [4 * 1]
				lesser-or-equal? 4 count dice 2 [4 * 2]
				lesser-or-equal? 4 count dice 3 [4 * 3]
				lesser-or-equal? 4 count dice 4 [4 * 4]
				lesser-or-equal? 4 count dice 5 [4 * 5]
				lesser-or-equal? 4 count dice 6 [4 * 6]
			]
		]
		"little straight"	[if [1 2 3 4 5] = sort dice [30]]
		"big straight" 		[if [2 3 4 5 6] = sort dice [30]]
		"choice" 			[sum dice]
	] [
		0
	]

	case [
		none? value [0]
		true value
	]
]

count: function [
	dice
	value
] [
	tally: 0
	foreach die dice [
		if die = value [tally: tally + 1]
	]
	tally
]
