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
		throw #(error: "span must be smaller than string length")		;--  'throw / 'catch is one method of error control…
	]
	if span < 0 [
		cause-error 'user 'message ["span must be greater than zero"]	;--   …and 'cause-error / 'try is another one.
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
		;probe integers
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
