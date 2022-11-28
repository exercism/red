Red [
	description: {"Largest Series Product" exercise solution for exercism platform}
	author: "loziniak"
]

largest-product: function [
	digits [string!]
	span [integer!]
	return: [integer!]
] [
	if span > length? digits [
		cause-error 'user 'message ["span must be smaller than string length"]
	]
	if span < 0 [
		do make error! "span must be greater than zero"		;-- this is synonymous to "cause-error 'user 'message"
	]
	integers: copy []
	foreach digit digits [
		if any [digit < #"0" digit > #"9"] [
			cause-error 'user 'message ["digits input must only contain digits"]
		]
		append integers to integer! (digit - #"0")
	]
	
	max-product: either zero? span [1] [0]
	 
	len: length? integers
	forall integers [
		if (span - 1 + index? integers) > len [
			break
		]
		product: 1
		foreach int copy/part integers span [
			product: product * int
		]
		if max-product < product [
			max-product: product
		]
	]
	
	max-product
]
