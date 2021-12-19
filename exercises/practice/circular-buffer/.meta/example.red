Red [
	description: {"Circular Buffer" exercise solution for exercism platform}
	author: "loziniak"
]

circular-buffer!: context [
	buffer: none
	results: none
	
	start: 1
	length: 0
	
	
	full?: function [return: [logic!]] [
		(length + 1) > length? buffer
	]
	
	write-end: function [item [integer!]] [
		end: ((start - 1 + length) % length? buffer) + 1
		buffer/(end): item
	]
	
	consume: function [] [
		self/start: (self/start % length? buffer) + 1
	]
	
	
	read: function [
		/extern start length
	] [
		append results either any [
			none? buffer
			length < 1
		] [
			'false
		] [
			result: buffer/(start)
			consume
			length: length - 1

			result
		]
	]

	write: function [
		item [integer!]
		/extern start length
	] [
		append results either any [
			none? buffer
			full?
		] [
			'false
		] [
			write-end item
			length: length + 1

			'true
		]
	]
	
	clear: function [
		/extern start length
	] [
		length: 0
	]

	overwrite: function [
		item [integer!]
		/extern start length
	] [
		unless none? buffer [
			write-end item
			
			either full? [
				consume
			] [
				length: length + 1
			]
		]
	]
]

run: function [
	capacity [integer!]
	operations [block!]
	return: [block!]
] [
	buf: make circular-buffer! [
		buffer: append/dup  copy []  none  capacity
		results: copy []
	]
	
	bind operations buf
	
	do operations
	buf/results
]
