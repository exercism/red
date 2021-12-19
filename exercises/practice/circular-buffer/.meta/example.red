Red [
	description: {"Circular Buffer" exercise solution for exercism platform}
	author: "loziniak"
]

circular-buffer!: context [
	buffer: none
	results: none
	
	start: 1
	length: 0
	
	read: function [
		/extern start length
	] [
		append results either any [
			none? buffer
			length < 1
		] [
			'false
		] [
			out: buffer/(start)
			start: (start % length? buffer) + 1
			length: length - 1
			out
		]
	]

	write: function [
		item [integer!]
		/extern start length
	] [
		append results either any [
			none? buffer
			(length + 1) > length? buffer
		] [
			'false
		] [
			pos: ((start - 1 + length) % length? buffer) + 1
			buffer/(pos): item
			length: length + 1
			'true
		]
	]
	
	clear: function [
		/extern start length
	] [
		length: 0
	]

	overwrite: function [] [append results 'unimplemented]
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
