Red [
	description: {"Hamming" exercise solution for exercism platform}
	author: "BNAndras"
]

distance: function [
	strand1
	strand2
] [
	count: 0
	if (length? strand1) <> (length? strand2) [
		cause-error 'user 'message "strands must be of equal length"
	]

	i: 0
	while [i <= length? strand1] [
		if (pick strand1 i) <> (pick strand2 i) [
			count: count + 1
		]

		i: i + 1
	]

	count
]

