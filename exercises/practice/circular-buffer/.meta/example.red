Red [
	description: {"Circular Buffer" exercise solution for exercism platform}
	author: "loziniak"
]

circular-buffer!: context [
	buffer: none
	results: none
	
	start: 1
	length: 0
	
	read: function [] [
;		probe "rrr"
		append results either any [
			none? buffer
			start > length
		] [
			'false
		] [
			buffer/(start)
		]
	]

	write: function [
		item [integer!]
		/extern length
	] [
;		probe "www"
		append results either any [
			none? buffer
		] [
			'false
		] [
			buffer/(start): item
			length: length + 1
			'true
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
