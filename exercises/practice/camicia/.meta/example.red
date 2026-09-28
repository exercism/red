Red [
	description: {"Camicia" exercise solution for Exercism}
	author: "BNAndras"
]

simulate-game: function [
	playerA
	playerB
] [
	game-result: function [status tricks cards] [
		make map! reduce [
			'status status
			'tricks tricks
			'cards cards
		]
	]

	next-turn: function [current-turn] [
		either current-turn = 'A ['B] ['A]
	]

	card-value: function [card] [
		switch/default card [
			"J" [1]
			"Q" [2]
			"K" [3]
			"A" [4]
		] [0]
	]

	hand-a: copy []
	foreach card playerA [append hand-a card-value card]
	hand-b: copy []
	foreach card playerB [append hand-b card-value card]
	pile: copy []
	seen: make map! 1000
	turn: 'A
	debt: 0
	tricks: 0
	cards: 0

	while [true] [
		if empty? pile [
			state: mold reduce [hand-a hand-b turn]
			if select seen state [
				return game-result "loop" tricks cards
			]
			put seen state true
		]

		either turn = 'A [
			active-hand: hand-a
			other-hand: hand-b
		] [
			active-hand: hand-b
			other-hand: hand-a
		]

		if empty? active-hand [
			return game-result "finished" (tricks + either empty? pile [0] [1]) cards
		]

		value: take active-hand
		append pile value
		cards: cards + 1

		either positive? value [
			debt: value
			turn: next-turn turn
		] [
			either positive? debt [
				debt: debt - 1
				if zero? debt [
					append other-hand pile
					clear pile
					tricks: tricks + 1

					if any [empty? hand-a empty? hand-b] [
						return game-result "finished" tricks cards
					]
					turn: next-turn turn
				]
			] [
				turn: next-turn turn
			]
		]
	]
]
