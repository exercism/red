Red [
	description: {"Phone Number" exercise solution for exercism platform}
	author: "BNAndras"
]

clean: function [
	phrase
] [
	cleaned: ""

	foreach char phrase [

		if (char >= #"a") and (char <= #"z") [
			cause-error 'user 'message "letters not permitted"
		]

		if (char >= #"A") and (char <= #"Z") [
			cause-error 'user 'message "letters not permitted"
		]		

		if (char = #"@") or (char = #"!") or (char = #":") [
			cause-error 'user 'message "punctuations not permitted"
		]


		if (char >= #"0") and (char <= #"9") [
			append cleaned char
		]
	]

	if 10 > length? cleaned [
		cause-error 'user 'message "must not be fewer than 10 digits"
	]

	if 11 < length? cleaned [
		cause-error 'user 'message "must not be greater than 11 digits"
	]

	if (11 = length? cleaned) and (#"1" <> first cleaned) [
		cause-error 'user 'message "11 digits must start with 1"
	]

	if (11 = length? cleaned) [
		remove/part cleaned 1
	]

	if 11 = length? cleaned [
		remove/part cleaned 1
	]

	if #"0" = cleaned/1 [
		cause-error 'user 'message "area code cannot start with zero"
	]

	if #"1" = cleaned/1 [
		cause-error 'user 'message "area code cannot start with one"
	]

	if #"0" = cleaned/4 [
		cause-error 'user 'message "exchange code cannot start with zero"
	]

	if #"1" = cleaned/4 [
		cause-error 'user 'message "exchange code cannot start with one"
	]

	cleaned
]
