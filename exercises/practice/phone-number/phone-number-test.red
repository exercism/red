Red [
	description: {Tests for "Phone Number" Exercism exercise}
	author: "loziniak"
]

#include %testlib.red

test-init/limit %phone-number.red 1
; test-init/limit %.meta/example.red 1						; test example solution

canonical-cases: [#[
    description: "cleans the number"
    input: #[
        phrase: "(223) 456-7890"
    ]
    expected: "2234567890"
    function: "clean"
    uuid: "79666dce-e0f1-46de-95a1-563802913c35"
] #[
    description: "cleans numbers with dots"
    input: #[
        phrase: "223.456.7890"
    ]
    expected: "2234567890"
    function: "clean"
    uuid: "c360451f-549f-43e4-8aba-fdf6cb0bf83f"
] #[
    description: "cleans numbers with multiple spaces"
    input: #[
        phrase: "223 456   7890   "
    ]
    expected: "2234567890"
    function: "clean"
    uuid: "08f94c34-9a37-46a2-a123-2a8e9727395d"
]#[
    description: "invalid when 9 digits"
    input: #[
        phrase: "123456789"
    ]
    expected: #[
        error: "must not be fewer than 10 digits"
    ]
    function: "clean"
    uuid: "2de74156-f646-42b5-8638-0ef1d8b58bc2"
] #[
    description: "invalid when 11 digits does not start with a 1"
    input: #[
        phrase: "22234567890"
    ]
    expected: #[
        error: "11 digits must start with 1"
    ]
    function: "clean"
    uuid: "57061c72-07b5-431f-9766-d97da7c4399d"
] #[
    description: "valid when 11 digits and starting with 1"
    input: #[
        phrase: "12234567890"
    ]
    expected: "2234567890"
    function: "clean"
    uuid: "9962cbf3-97bb-4118-ba9b-38ff49c64430"
] #[
    description: {valid when 11 digits and starting with 1 even with punctuation}
    input: #[
        phrase: "+1 (223) 456-7890"
    ]
    expected: "2234567890"
    function: "clean"
    uuid: "fa724fbf-054c-4d91-95da-f65ab5b6dbca"
] #[
    description: "invalid when more than 11 digits"
    input: #[
        phrase: "321234567890"
    ]
    expected: #[
        error: "must not be greater than 11 digits"
    ]
    function: "clean"
    uuid: "4a1509b7-8953-4eec-981b-c483358ff531"
] #[
    description: "invalid with letters"
    input: #[
        phrase: "523-abc-7890"
    ]
    expected: #[
        error: "letters not permitted"
    ]
    function: "clean"
    uuid: "eb8a1fc0-64e5-46d3-b0c6-33184208e28a"
] #[
    description: "invalid with punctuations"
    input: #[
        phrase: "523-@:!-7890"
    ]
    expected: #[
        error: "punctuations not permitted"
    ]
    function: "clean"
    uuid: "065f6363-8394-4759-b080-e6c8c351dd1f"
] #[
    description: "invalid if area code starts with 0"
    input: #[
        phrase: "(023) 456-7890"
    ]
    expected: #[
        error: "area code cannot start with zero"
    ]
    function: "clean"
    uuid: "d77d07f8-873c-4b17-8978-5f66139bf7d7"
] #[
    description: "invalid if area code starts with 1"
    input: #[
        phrase: "(123) 456-7890"
    ]
    expected: #[
        error: "area code cannot start with one"
    ]
    function: "clean"
    uuid: "c7485cfb-1e7b-4081-8e96-8cdb3b77f15e"
] #[
    description: "invalid if exchange code starts with 0"
    input: #[
        phrase: "(223) 056-7890"
    ]
    expected: #[
        error: "exchange code cannot start with zero"
    ]
    function: "clean"
    uuid: "4d622293-6976-413d-b8bf-dd8a94d4e2ac"
] #[
    description: "invalid if exchange code starts with 1"
    input: #[
        phrase: "(223) 156-7890"
    ]
    expected: #[
        error: "exchange code cannot start with one"
    ]
    function: "clean"
    uuid: "4cef57b4-7d8e-43aa-8328-1e1b89001262"
] #[
    description: {invalid if area code starts with 0 on valid 11-digit number}
    input: #[
        phrase: "1 (023) 456-7890"
    ]
    expected: #[
        error: "area code cannot start with zero"
    ]
    function: "clean"
    uuid: "9925b09c-1a0d-4960-a197-5d163cbe308c"
] #[
    description: {invalid if area code starts with 1 on valid 11-digit number}
    input: #[
        phrase: "1 (123) 456-7890"
    ]
    expected: #[
        error: "area code cannot start with one"
    ]
    function: "clean"
    uuid: "3f809d37-40f3-44b5-ad90-535838b1a816"
] #[
    description: {invalid if exchange code starts with 0 on valid 11-digit number}
    input: #[
        phrase: "1 (223) 056-7890"
    ]
    expected: #[
        error: "exchange code cannot start with zero"
    ]
    function: "clean"
    uuid: "e08e5532-d621-40d4-b0cc-96c159276b65"
] #[
    description: {invalid if exchange code starts with 1 on valid 11-digit number}
    input: #[
        phrase: "1 (223) 156-7890"
    ]
    expected: #[
        error: "exchange code cannot start with one"
    ]
    function: "clean"
    uuid: "57b32f3d-696a-455c-8bf1-137b6d171cdf"
]]


foreach c-case canonical-cases [
	expect-code: compose [
		(to word! c-case/function) (values-of c-case/input)
	]
	case-code: reduce
		either all [
			map? c-case/expected
			string? c-case/expected/error
		] [
			['expect-error/message quote 'user expect-code c-case/expected/error]
		] [
			['expect c-case/expected expect-code]
		]

	test c-case/description case-code
]

test-results/print
