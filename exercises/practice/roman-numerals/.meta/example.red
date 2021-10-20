Red [
	description: {"Roman Numerals" exercise solution for exercism platform}
	author: "dockimbel"
	source: http://www.rosettacode.org/wiki/Roman_numerals/Encode#Red
]

table: [1000 M 900 CM 500 D 400 CD 100 C 90 XC 50 L 40 XL 10 X 9 IX 5 V 4 IV 1 I]

roman: function [
	number [integer!]
	return: [string!]
	/extern table
] [
	case [
		tail? table      [table: head table copy ""]
		table/1 > number [table: skip table 2 roman number]
		true             [append copy form table/2 roman number - table/1]
	]
]
