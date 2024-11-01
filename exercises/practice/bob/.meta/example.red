Red [
	description: {"Bob" exercise solution for exercism platform}
	author: "BNAndras"
]

response: function [
	heyBob
] [
	case [
		silent? heyBob [ "Fine. Be that way!" ]
		loud-question? heyBob [ "Calm down, I know what I'm doing!" ]
		loud-statement? heyBob [ "Whoa, chill out!" ]
		question? heyBob [ "Sure." ]
		true [ "Whatever." ]
	]
]

silent?: function [
	message
] [
	"" == trim message
]

loud-question?: function [
	message
] [
	and~ loud? message
		 question? message
]

loud-statement?: function [
	message
] [
	loud? message
]

question?: function [
	message
] [
	#"?" == last trim message
]

loud?: function [
	message
] [
	and~ has-letter? message
		 message == uppercase copy message
]

has-letter?: func [phrase][
    not none? find phrase charset [#"a" - #"z" #"A" - #"Z"]
]
