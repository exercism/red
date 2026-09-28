Red [
	description: {"Conway's Game of Life" exercise solution for exercism platform}
	author: "BNAndras"
]

tick: function [
	matrix
] [
	if empty? matrix [return []]

	rows: length? matrix
	columns: length? first matrix
	next-generation: copy []

	repeat row-index rows [
		next-row: copy []

		repeat column-index columns [
			live-neighbors: 0

			repeat row-offset-index 3 [
				row-offset: row-offset-index - 2
				repeat column-offset-index 3 [
					column-offset: column-offset-index - 2
					neighbor-row: row-index + row-offset
					neighbor-column: column-index + column-offset

					if all [
						not all [row-offset = 0 column-offset = 0]
						neighbor-row >= 1
						neighbor-row <= rows
						neighbor-column >= 1
						neighbor-column <= columns
					] [
						live-neighbors: live-neighbors + pick pick matrix neighbor-row neighbor-column
					]
				]
			]

			cell: pick pick matrix row-index column-index
			append next-row either cell = 1 [
				either any [live-neighbors < 2 live-neighbors > 3] [0] [1]
			] [
				either live-neighbors = 3 [1] [0]
			]
		]

		append/only next-generation next-row
	]

	next-generation
]
