Red [
	description: {Tests for "Matching Brackets" Exercism exercise}
	author: "loziniak"
]

#include %testlib.red

test-init/limit %matching-brackets.red 1
; test-init/limit %.meta/example.red 1						; test example solution

canonical-cases: [#[
    description: "paired square brackets"
    input: #[
        value: "[]"
    ]
    expected: true
    function: "is-paired"
    uuid: "81ec11da-38dd-442a-bcf9-3de7754609a5"
] #[
    description: "empty string"
    input: #[
        value: ""
    ]
    expected: true
    function: "is-paired"
    uuid: "287f0167-ac60-4b64-8452-a0aa8f4e5238"
] #[
    description: "unpaired brackets"
    input: #[
        value: "[["
    ]
    expected: false
    function: "is-paired"
    uuid: "6c3615a3-df01-4130-a731-8ef5f5d78dac"
] #[
    description: "wrong ordered brackets"
    input: #[
        value: "}{"
    ]
    expected: false
    function: "is-paired"
    uuid: "9d414171-9b98-4cac-a4e5-941039a97a77"
] #[
    description: "wrong closing bracket"
    input: #[
        value: "{]"
    ]
    expected: false
    function: "is-paired"
    uuid: "f0f97c94-a149-4736-bc61-f2c5148ffb85"
] #[
    description: "paired with whitespace"
    input: #[
        value: "{ }"
    ]
    expected: true
    function: "is-paired"
    uuid: "754468e0-4696-4582-a30e-534d47d69756"
] #[
    description: "partially paired brackets"
    input: #[
        value: "{[])"
    ]
    expected: false
    function: "is-paired"
    uuid: "ba84f6ee-8164-434a-9c3e-b02c7f8e8545"
] #[
    description: "simple nested brackets"
    input: #[
        value: "{[]}"
    ]
    expected: true
    function: "is-paired"
    uuid: "3c86c897-5ff3-4a2b-ad9b-47ac3a30651d"
] #[
    description: "several paired brackets"
    input: #[
        value: "{}[]"
    ]
    expected: true
    function: "is-paired"
    uuid: "2d137f2c-a19e-4993-9830-83967a2d4726"
] #[
    description: "paired and nested brackets"
    input: #[
        value: "([{}({}[])])"
    ]
    expected: true
    function: "is-paired"
    uuid: "2e1f7b56-c137-4c92-9781-958638885a44"
] #[
    description: "unopened closing brackets"
    input: #[
        value: "{[)][]}"
    ]
    expected: false
    function: "is-paired"
    uuid: "84f6233b-e0f7-4077-8966-8085d295c19b"
] #[
    description: "unpaired and nested brackets"
    input: #[
        value: "([{])"
    ]
    expected: false
    function: "is-paired"
    uuid: "9b18c67d-7595-4982-b2c5-4cb949745d49"
] #[
    description: "paired and wrong nested brackets"
    input: #[
        value: "[({]})"
    ]
    expected: false
    function: "is-paired"
    uuid: "a0205e34-c2ac-49e6-a88a-899508d7d68e"
] #[
    description: {paired and wrong nested brackets but innermost are correct}
    input: #[
        value: "[({}])"
    ]
    expected: false
    function: "is-paired"
    uuid: "1d5c093f-fc84-41fb-8c2a-e052f9581602"
] #[
    description: "paired and incomplete brackets"
    input: #[
        value: "{}["
    ]
    expected: false
    function: "is-paired"
    uuid: "ef47c21b-bcfd-4998-844c-7ad5daad90a8"
] #[
    description: "too many closing brackets"
    input: #[
        value: "[]]"
    ]
    expected: false
    function: "is-paired"
    uuid: "a4675a40-a8be-4fc2-bc47-2a282ce6edbe"
] #[
    description: "early unexpected brackets"
    input: #[
        value: ")()"
    ]
    expected: false
    function: "is-paired"
    uuid: "a345a753-d889-4b7e-99ae-34ac85910d1a"
] #[
    description: "early mismatched brackets"
    input: #[
        value: "{)()"
    ]
    expected: false
    function: "is-paired"
    uuid: "21f81d61-1608-465a-b850-baa44c5def83"
] #[
    description: "math expression"
    input: #[
        value: "(((185 + 223.85) * 15) - 543)/2"
    ]
    expected: true
    function: "is-paired"
    uuid: "99255f93-261b-4435-a352-02bdecc9bdf2"
] #[
    description: "complex latex expression"
    input: #[
        value: {\left(\begin{array}{cc} \frac{1}{3} & x\\ \mathrm{e}^^{x} &... x^^2 \end{array}\right)}
    ]
    expected: true
    function: "is-paired"
    uuid: "8e357d79-f302-469a-8515-2561877256a1"
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
