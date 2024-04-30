Red [
	description: {"Allergies" exercise solution for exercism platform}
	author: "BNAndras"
]

ALLERGIES: #[
	"eggs"      	1
	"peanuts"	    2
	"shellfish" 	4
	"strawberries"  8
	"tomatoes"      16
	"chocolate"     32
	"pollen"        64
	"cats"          128
]


allergic-to: function [
	item
	score
] [
	0 <> and~ score (select ALLERGIES item)
]

list: function [
	score
] [
	results: copy []
	foreach [item value] ALLERGIES [
		if 0 <> and~ score value [
			append results item
		]
	]

	results
]

