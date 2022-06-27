Red [
	description: {"POV" exercise solution for exercism platform}
	author: "kickass"
]

rebranch: function [
	parent [map!]
	current [map!]
] [
	if not block? current/children [current/children: copy []]
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
	print "^/"
	probe parent
	probe current
	probe from
	either current/label = from [
		if map? parent [rebranch parent current]
		return current
	] [
		if block? current/children [
			foreach child current/children [
				probe new-tree: from-pov-internal current child from
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

path-to: function [
	from [string!]
	to [string!]
	tree [map!]
	return: [block! none!]
] [
	cause-error 'user 'message "You need to implement path-to function."
]

