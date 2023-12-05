Red [
	description: {"Triangle" exercise solution for exercism platform}
	author: "BNAndras"
]

equilateral: function [
	sides
] [
	true? all [
		valid-triangle? sides
		equal? length? unique sides 1
	]
]

isosceles: function [
	sides
] [
	true? all [
		valid-triangle? sides
		not-equal? length? unique sides 3
	]
]

scalene: function [
	sides
] [
	true? all [
		valid-triangle? sides
		equal? length? unique sides 3
	]
]

valid-triangle?: function [
	sides
] [
	sort sides
	side1: sides/1
	side2: sides/2
	side3: sides/3

	all [
		foreach side sides [positive? side]
		greater-or-equal? add side1 side2 side3
	]
]

true?: function [
	val
] [not not val]