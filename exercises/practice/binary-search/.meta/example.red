Red [
	description: {"Binary Search" exercise solution for exercism platform}
	author: "BNAndras"
]

find: function [
	array
	value
] [
	start: 1
	stop: length? array
	while [start <= stop] [
		index: to-integer divide (add start stop) 2
		median: pick array index
		case [
			median = value [ return index ]
			median < value [ start: add index 1 ]
			median > value [ stop: subtract index 1 ]
		]
	]

	cause-error 'user 'message "value not in array"
]

