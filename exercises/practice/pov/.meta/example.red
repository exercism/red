Red [
	description: {"POV" exercise solution for exercism platform}
	author: "loziniak"
]

rebranch: function [
	parent [map!]
	current [map!]
] [
	unless block? current/children [current/children: copy []]
	append current/children parent
	remove find parent/children current
	if empty? parent/children [remove/key parent 'children]
]

from-pov-internal: function [
	parent [map! none!]
	current [map!]
	from [string!]
	return: [map! none!]
] [
	either current/label = from [
		if map? parent [rebranch parent current]
		return current
	] [
		if block? current/children [
			foreach child current/children [
				new-tree: from-pov-internal current child from
				if map? new-tree [
					if map? parent [rebranch parent current]
					return new-tree
				]
			]
		]
	]
	return none
]

from-pov: function [
	tree [map!]
	from [string!]
	return: [map! none!]
] [
	return from-pov-internal none tree from
]



path-to-internal: function [
	current [map!]
	finish [string!]
	path [block!]
	return: [logic!]
] [
	append path current/label
	either current/label = finish [
		return true
	] [
		if block? current/children [
			foreach child current/children [
				if path-to-internal child finish path [
					return true
				]
			]
		]
	]
	remove back tail path
	return false
]

path-to: function [
	start [string!]
	finish [string!]
	tree [map!]
	return: [block! none!]
] [
	rerooted: from-pov tree start
	
	path: copy []
	if map? rerooted [
		path-to-internal rerooted finish path
	]

	return either
		all [
			not empty? path
			start = first path
			finish = last path
	] [
		path
	] [
		none
	]
]
