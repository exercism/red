Red [
	description: {"Simple Linked List" exercise solution for exercism platform}
	author: "loziniak"
]


new-list: function [
	values [block!]
] [
	list: make map! reduce ['head none]
	foreach value values [
		list/head: reduce [value list/head]
	]
	list
]

list-count: function [
	list [map!]
] [
	size: 0
	node: list/head
	while [not none? node] [
		size: size + 1
		node: node/2
	]
	size
]

list-push: function [
	list [map!]
	value [integer!]
] [
	list/head: reduce [value list/head]
]

list-pop: function [
	list [map!]
] [
	if none? list/head [
		cause-error 'user 'message "list is empty"
	]
	value: list/head/1
	list/head: list/head/2
	value
]

list-peek: function [
	list [map!]
] [
	if none? list/head [
		cause-error 'user 'message "list is empty"
	]
	list/head/1
]

list-to-array: function [
	list [map!]
] [
	array: copy []
	node: list/head
	while [not none? node] [
		append array node/1
		node: node/2
	]
	reverse array
]

list-reverse: function [
	list [map!]
] [
	reversed: none
	node: list/head
	while [not none? node] [
		reversed: reduce [node/1 reversed]
		node: node/2
	]
	list/head: reversed
]
