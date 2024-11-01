Red [
	description: {"Matching Brackets" exercise solution for exercism platform}
	author: "BNAndras"
]

is-paired: function [
	value
] [
	stack: []

	foreach char value [

		if find [#"[" #"{" #"("] char [
			append stack char
		]

		if find [#"]" #"}" #")"] char [
			if empty? stack [
				return false
			]

			candidate: take/last stack

			if and~ candidate = #"[" char <> #"]" [
				return false
			]
			
			if and~ candidate = #"{" char <> #"}" [
				return false
			]
			if and~ candidate = #"(" char <> #")" [
				return false
			]
		]
	]


	empty? stack
]

