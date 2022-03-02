Red [
	description: {"Simple Linked List" exercise solution for exercism platform}
	author: "loziniak"
]


to-array: function [
	list [block! none!]
	return: [vector!]
] [
	array: make vector! []
	while [not none? list] [
		append array list/1
		list: list/2
	]
	array
]

from-array: function [
	array [vector!]
	return: [block! none!]
] [
	list: none
	loop element: length? array [
		list: reduce [array/(element) list]
		element: element - 1
	]
	list
]

reverse-list: function [
	list [block! none!]
	return: [block! none!]
] [
	reversed: none
	while [not none? list] [
		reversed: reduce [list/1 reversed]
		list: list/2
	]	
	reversed
]


from-array-and-back: function [
	array [block!]
	return: [block!]
] [
	to block!  to-array from-array  make vector! array
]

convert-reverse-convert-back: function [
	array [block!]
	return: [block!]
] [
	to block!  to-array reverse-list from-array  make vector! array
]
