Red [
	description: {"ETL" exercise solution for exercism platform}
	author: "BNAndras"
]

transform: function [
	legacy
] [
	transformed: #[]

	foreach [score letters] legacy [
		foreach letter letters [
			transformed/(to-word lowercase letter): to integer! score
		]
	]

	transformed
]
