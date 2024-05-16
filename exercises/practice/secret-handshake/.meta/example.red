Red [
	description: {"Secret Handshake" exercise solution for exercism platform}
	author: "BNAndras"
]

commands: function [
	number
] [
	actions: copy []
	binary: reverse take/last/part form any [find enbase/base to-binary number 2 "1" "0"] 5
	
	repeat i (length? binary) [
		if binary/:i = #"1" [
			switch i [
				1 [append actions "wink"]
				2 [append actions "double blink"]
				3 [append actions "close your eyes"]
				4 [append actions "jump"]
				5 [reverse actions]
			]
		]
	]

	actions
]

