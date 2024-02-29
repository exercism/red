Red [
	description: {Tests for "Acronym" Exercism exercise}
	author: "loziniak"
]

#include %testlib.red

test-init/limit %acronym.red 1
; test-init/limit %.meta/example.red 1						; test example solution

canonical-cases: [#(
    description: "basic"
    input: #(
        phrase: "Portable Network Graphics"
    )
    expected: "PNG"
    function: "abbreviate"
    uuid: "1e22cceb-c5e4-4562-9afe-aef07ad1eaf4"
) #(
    description: "lowercase words"
    input: #(
        phrase: "Ruby on Rails"
    )
    expected: "ROR"
    function: "abbreviate"
    uuid: "79ae3889-a5c0-4b01-baf0-232d31180c08"
) #(
    description: "punctuation"
    input: #(
        phrase: "First In, First Out"
    )
    expected: "FIFO"
    function: "abbreviate"
    uuid: "ec7000a7-3931-4a17-890e-33ca2073a548"
) #(
    description: "all caps word"
    input: #(
        phrase: "GNU Image Manipulation Program"
    )
    expected: "GIMP"
    function: "abbreviate"
    uuid: "32dd261c-0c92-469a-9c5c-b192e94a63b0"
) #(
    description: "punctuation without whitespace"
    input: #(
        phrase: "Complementary metal-oxide semiconductor"
    )
    expected: "CMOS"
    function: "abbreviate"
    uuid: "ae2ac9fa-a606-4d05-8244-3bcc4659c1d4"
) #(
    description: "very long abbreviation"
    input: #(
        phrase: {Rolling On The Floor Laughing So Hard That My Dogs Came Over And Licked Me}
    )
    expected: "ROTFLSHTMDCOALM"
    function: "abbreviate"
    uuid: "0e4b1e7c-1a6d-48fb-81a7-bf65eb9e69f9"
) #(
    description: "consecutive delimiters"
    input: #(
        phrase: "Something - I made up from thin air"
    )
    expected: "SIMUFTA"
    function: "abbreviate"
    uuid: "6a078f49-c68d-4b7b-89af-33a1a98c28cc"
) #(
    description: "apostrophes"
    input: #(
        phrase: "Halley's Comet"
    )
    expected: "HC"
    function: "abbreviate"
    uuid: "5118b4b1-4572-434c-8d57-5b762e57973e"
) #(
    description: "underscore emphasis"
    input: #(
        phrase: "The Road _Not_ Taken"
    )
    expected: "TRNT"
    function: "abbreviate"
    uuid: "adc12eab-ec2d-414f-b48c-66a4fc06cdef"
)]


foreach c-case canonical-cases [
	case-code: reduce [
		'expect c-case/expected compose [
			(to word! c-case/function) (values-of c-case/input)
		] 
	]

	test c-case/description case-code
]

test-results/print
