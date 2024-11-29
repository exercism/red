Red [
	description: {"Bottle Song" exercise solution for exercism platform}
	author: "BNAndras"
]

recite: function [
	startBottles
	takeDown
] [
    verses: []
	stop: startBottles - takeDown
	i: startBottles
	while [i > stop] [
		next: i - 1
		either i > 1 [
			append verses rejoin [
				uppercase/part number-to-word i 1 " green bottles hanging on the wall,"
				newline
				uppercase/part number-to-word i 1 " green bottles hanging on the wall,"
				newline
				"And if one green bottle should accidentally fall,"
				newline
				"There'll be " number-to-word next " green " pluralize next " hanging on the wall."
			]
		] [
			append verses rejoin [
				"One green bottle hanging on the wall,"
				newline
				"One green bottle hanging on the wall,"
				newline
				"And if one green bottle should accidentally fall,"
				newline
				"There'll be no green bottles hanging on the wall."
			]
		]
		i: next
	]

    results: ""
    repeat index (length? verses) [
        append results verses/:index
        if index < length? verses [
            append results newline
            append results newline
        ]
    ]
    results
]

number-to-word: function [
	number
] [
	either number = 0 [
		"no"
	] [
	words: [
		"one" "two" "three" "four" "five" "six" "seven" "eight" "nine" "ten"
	]
		words/(number)
	]
]

pluralize: function [
	count
] [
	either count = 1 [
		"bottle"
	] [
		"bottles"
	]
]
