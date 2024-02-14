Red [
	description: {"List Ops" exercise solution for exercism platform}
	author: "BNAndras"
]

append: function [
	list1
	list2
] [
	len: length? list1
	if len == 0 [
		return list2
	]
	rest: next copy list1

	reduce [ first list1 append rest list2 ]
]

concat: function [
	lists
] [
	foldl lists append
]

filter: function [
	list
	f
] [
	results: []
	foreach item list [
		if f item [append results item]
	]
	results
]

length: function [
	list
] [
	foldl list function [acc x] [acc + 1]
]

map: function [
	list
	f
] [
	results: []
	foreach item list [
		append results f item
	]
	results
]

foldl: function [
	list
	initial
	f
] [
	len: length? list
	if len == 0 [
		return initial
	]

	results: initial
	foreach item list [
		results: f results item
	]

	results
]

foldr: function [
	list
	initial
	f
] [
	len: length? list
	if len == 0 [
		return initial
	]

	results: initial
	foreach index count-backwards length? list [
		result: f pick list index results
	]
	
	results
]

reverse: function [
	list
] [
	results: []
	foreach index count-backwards length? list [
		append results pick list index
	]
	results
]

count-backwards: function [
	start
] [
	results: []
	n: start
	while [n >= 0] [
		append results n
		n: n - 1
	]
	results
]
