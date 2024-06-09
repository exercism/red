Red [
	description: {Tests for "Isogram" Exercism exercise}
	author: "loziniak"
]

#include %testlib.red

test-init/limit %isogram.red 1
; test-init/limit %.meta/example.red 1						; test example solution

canonical-cases: [#[
    description: "empty string"
    input: #[
        phrase: ""
    ]
    expected: true
    function: "is-isogram"
    uuid: "a0e97d2d-669e-47c7-8134-518a1e2c4555"
] #[
    description: "isogram with only lower case characters"
    input: #[
        phrase: "isogram"
    ]
    expected: true
    function: "is-isogram"
    uuid: "9a001b50-f194-4143-bc29-2af5ec1ef652"
] #[
    description: "word with one duplicated character"
    input: #[
        phrase: "eleven"
    ]
    expected: false
    function: "is-isogram"
    uuid: "8ddb0ca3-276e-4f8b-89da-d95d5bae78a4"
] #[
    description: {word with one duplicated character from the end of the alphabet}
    input: #[
        phrase: "zzyzx"
    ]
    expected: false
    function: "is-isogram"
    uuid: "6450b333-cbc2-4b24-a723-0b459b34fe18"
] #[
    description: "longest reported english isogram"
    input: #[
        phrase: "subdermatoglyphic"
    ]
    expected: true
    function: "is-isogram"
    uuid: "a15ff557-dd04-4764-99e7-02cc1a385863"
] #[
    description: "word with duplicated character in mixed case"
    input: #[
        phrase: "Alphabet"
    ]
    expected: false
    function: "is-isogram"
    uuid: "f1a7f6c7-a42f-4915-91d7-35b2ea11c92e"
] #[
    description: {word with duplicated character in mixed case, lowercase first}
    input: #[
        phrase: "alphAbet"
    ]
    expected: false
    function: "is-isogram"
    uuid: "14a4f3c1-3b47-4695-b645-53d328298942"
] #[
    description: "hypothetical isogrammic word with hyphen"
    input: #[
        phrase: "thumbscrew-japingly"
    ]
    expected: true
    function: "is-isogram"
    uuid: "423b850c-7090-4a8a-b057-97f1cadd7c42"
] #[
    description: {hypothetical word with duplicated character following hyphen}
    input: #[
        phrase: "thumbscrew-jappingly"
    ]
    expected: false
    function: "is-isogram"
    uuid: "93dbeaa0-3c5a-45c2-8b25-428b8eacd4f2"
] #[
    description: "isogram with duplicated hyphen"
    input: #[
        phrase: "six-year-old"
    ]
    expected: true
    function: "is-isogram"
    uuid: "36b30e5c-173f-49c6-a515-93a3e825553f"
] #[
    description: "made-up name that is an isogram"
    input: #[
        phrase: "Emily Jung Schwartzkopf"
    ]
    expected: true
    function: "is-isogram"
    uuid: "cdabafa0-c9f4-4c1f-b142-689c6ee17d93"
] #[
    description: "duplicated character in the middle"
    input: #[
        phrase: "accentor"
    ]
    expected: false
    function: "is-isogram"
    uuid: "5fc61048-d74e-48fd-bc34-abfc21552d4d"
] #[
    description: "same first and last characters"
    input: #[
        phrase: "angola"
    ]
    expected: false
    function: "is-isogram"
    uuid: "310ac53d-8932-47bc-bbb4-b2b94f25a83e"
] #[
    description: {word with duplicated character and with two hyphens}
    input: #[
        phrase: "up-to-date"
    ]
    expected: false
    function: "is-isogram"
    uuid: "0d0b8644-0a1e-4a31-a432-2b3ee270d847"
]]


foreach c-case canonical-cases [
	case-code: reduce [
		'expect c-case/expected compose [
			(to word! c-case/function) (values-of c-case/input)
		] 
	]

	test c-case/description case-code
]

test-results/print
