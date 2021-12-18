Red [
	description: {"Circular Buffer" exercise solution for exercism platform}
	author: "loziniak"
]

circular-buffer!: context [
	buffer: none
	results: none
	
	read: function [] [append results 'false]
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
