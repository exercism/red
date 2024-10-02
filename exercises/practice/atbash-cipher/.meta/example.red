Red [
	description: {"Atbash Cipher" exercise solution for exercism platform}
	author: "BNAndras"
]

encode: function [
	phrase
] [
	count: 0
	result: copy ""

	foreach char lowercase phrase [
		if or~ whitespace? char punctuation? char [continue]


		if count = 5 [
			append result #" "
			count: 0
		]

		encoded: char
		if and~ char >= #"a" char <= #"z" [
			encoded: to-char (#"z" - char + #"a")
		]

		append result encoded

		count: count + 1
	]

	result
]

decode: function [
	phrase
] [
	count: 0
	result: copy ""

	foreach char phrase [
		if and~ char >= #"a" char <= #"z" [
			append result to-char (#"z" - char + #"a")
		]
		if and~ char >= #"0" char <= #"9" [
			append result char
		]
	]

	result
]

whitespace?: function [
	char
] [
	parse to-string char [any [" " | tab | newline]]
]

punctuation?: function [
	char
] [
	parse to-string char [any [#"." | "," | "!" | "?" | "'" ]]
]