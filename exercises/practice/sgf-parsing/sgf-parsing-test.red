Red [
	description: {Tests for SGF Parsing Exercism exercise}
	author: "loziniak"
]

#include %testlib.red

test-init/limit %sgf-parsing.red 1
; test-init/limit %.meta/example.red 1						; test example solution


canonical-cases: [#[
    description: "empty input"
    input: #[
        encoded: ""
    ]
    expected: #[
        error: "tree missing"
    ]
    function: "parse-sgf"
    uuid: "2668d5dc-109f-4f71-b9d5-8d06b1d6f1cd"
] #[
    description: "tree with no nodes"
    input: #[
        encoded: "()"
    ]
    expected: #[
        error: "tree with no nodes"
    ]
    function: "parse-sgf"
    uuid: "84ded10a-94df-4a30-9457-b50ccbdca813"
] #[
    description: "node without tree"
    input: #[
        encoded: ";"
    ]
    expected: #[
        error: "tree missing"
    ]
    function: "parse-sgf"
    uuid: "0a6311b2-c615-4fa7-800e-1b1cbb68833d"
] #[
    description: "node without properties"
    input: #[
        encoded: "(;)"
    ]
    expected: #[
        properties: #[]
        children: []
    ]
    function: "parse-sgf"
    uuid: "8c419ed8-28c4-49f6-8f2d-433e706110ef"
] #[
    description: "single node tree"
    input: #[
        encoded: "(;A[B])"
    ]
    expected: #[
        properties: #[
            A: ["B"]
        ]
        children: []
    ]
    function: "parse-sgf"
    uuid: "8209645f-32da-48fe-8e8f-b9b562c26b49"
] #[
    description: "multiple properties"
    input: #[
        encoded: "(;A[b]C[d])"
    ]
    expected: #[
        properties: #[
            A: ["b"]
            C: ["d"]
        ]
        children: []
    ]
    function: "parse-sgf"
    uuid: "6c995856-b919-4c75-8fd6-c2c3c31b37dc"
] #[
    description: "properties without delimiter"
    input: #[
        encoded: "(;A)"
    ]
    expected: #[
        error: "properties without delimiter"
    ]
    function: "parse-sgf"
    uuid: "a771f518-ec96-48ca-83c7-f8d39975645f"
] #[
    description: "all lowercase property"
    input: #[
        encoded: "(;a[b])"
    ]
    expected: #[
        error: "property must be in uppercase"
    ]
    function: "parse-sgf"
    uuid: "6c02a24e-6323-4ed5-9962-187d19e36bc8"
] #[
    description: "upper and lowercase property"
    input: #[
        encoded: "(;Aa[b])"
    ]
    expected: #[
        error: "property must be in uppercase"
    ]
    function: "parse-sgf"
    uuid: "8772d2b1-3c57-405a-93ac-0703b671adc1"
] #[
    description: "two nodes"
    input: #[
        encoded: "(;A[B];B[C])"
    ]
    expected: #[
        properties: #[
            A: ["B"]
        ]
        children: [#[
            properties: #[
                B: ["C"]
            ]
            children: []
        ]]
    ]
    function: "parse-sgf"
    uuid: "a759b652-240e-42ec-a6d2-3a08d834b9e2"
] #[
    description: "two child trees"
    input: #[
        encoded: "(;A[B](;B[C])(;C[D]))"
    ]
    expected: #[
        properties: #[
            A: ["B"]
        ]
        children: [#[
            properties: #[
                B: ["C"]
            ]
            children: []
        ] #[
            properties: #[
                C: ["D"]
            ]
            children: []
        ]]
    ]
    function: "parse-sgf"
    uuid: "cc7c02bc-6097-42c4-ab88-a07cb1533d00"
] #[
    description: "multiple property values"
    input: #[
        encoded: "(;A[b][c][d])"
    ]
    expected: #[
        properties: #[
            A: ["b" "c" "d"]
        ]
        children: []
    ]
    function: "parse-sgf"
    uuid: "724eeda6-00db-41b1-8aa9-4d5238ca0130"
] #[
    description: {within property values, whitespace characters such as tab are converted to spaces}
    input: #[
        encoded: "(;A[hello^-^-world])"
    ]
    expected: #[
        properties: #[
            A: ["hello  world"]
        ]
        children: []
    ]
    function: "parse-sgf"
    uuid: "28092c06-275f-4b9f-a6be-95663e69d4db"
] #[
    description: {within property values, newlines remain as newlines}
    input: #[
        encoded: "(;A[hello^/^/world])"
    ]
    expected: #[
        properties: #[
            A: ["hello^/^/world"]
        ]
        children: []
    ]
    function: "parse-sgf"
    uuid: "deaecb9d-b6df-4658-aa92-dcd70f4d472a"
] #[
    description: {escaped closing bracket within property value becomes just a closing bracket}
    input: #[
        encoded: "(;A[\]])"
    ]
    expected: #[
        properties: #[
            A: ["]"]
        ]
        children: []
    ]
    function: "parse-sgf"
    uuid: "8e4c970e-42d7-440e-bfef-5d7a296868ef"
] #[
    description: {escaped backslash in property value becomes just a backslash}
    input: #[
        encoded: "(;A[\\])"
    ]
    expected: #[
        properties: #[
            A: ["\"]
        ]
        children: []
    ]
    function: "parse-sgf"
    uuid: "cf371fa8-ba4a-45ec-82fb-38668edcb15f"
] #[
    description: {opening bracket within property value doesn't need to be escaped}
    input: #[
        encoded: "(;A[x[y\]z][foo]B[bar];C[baz])"
    ]
    expected: #[
        properties: #[
            A: ["x[y]z" "foo"]
            B: ["bar"]
        ]
        children: [#[
            properties: #[
                C: ["baz"]
            ]
            children: []
        ]]
    ]
    function: "parse-sgf"
    uuid: "dc13ca67-fac0-4b65-b3fe-c584d6a2c523"
] #[
    description: {semicolon in property value doesn't need to be escaped}
    input: #[
        encoded: "(;A[a;b][foo]B[bar];C[baz])"
    ]
    expected: #[
        properties: #[
            A: ["a;b" "foo"]
            B: ["bar"]
        ]
        children: [#[
            properties: #[
                C: ["baz"]
            ]
            children: []
        ]]
    ]
    function: "parse-sgf"
    uuid: "a780b97e-8dbb-474e-8f7e-4031902190e8"
] #[
    description: {parentheses in property value don't need to be escaped}
    input: #[
        encoded: "(;A[x(y)z][foo]B[bar];C[baz])"
    ]
    expected: #[
        properties: #[
            A: ["x(y)z" "foo"]
            B: ["bar"]
        ]
        children: [#[
            properties: #[
                C: ["baz"]
            ]
            children: []
        ]]
    ]
    function: "parse-sgf"
    uuid: "0b57a79e-8d89-49e5-82b6-2eaaa6b88ed7"
] #[
    description: {escaped tab in property value is converted to space}
    input: #[
        encoded: "(;A[hello\^-world])"
    ]
    expected: #[
        properties: #[
            A: ["hello world"]
        ]
        children: []
    ]
    function: "parse-sgf"
    uuid: "c72a33af-9e04-4cc5-9890-1b92262813ac"
] #[
    description: {escaped newline in property value is converted to nothing at all}
    input: #[
        encoded: "(;A[hello\^/world])"
    ]
    expected: #[
        properties: #[
            A: ["helloworld"]
        ]
        children: []
    ]
    function: "parse-sgf"
    uuid: "3a1023d2-7484-4498-8d73-3666bb386e81"
] #[
    description: {escaped t and n in property value are just letters, not whitespace}
    input: #[
        encoded: "(;A[\t = t and \n = n])"
    ]
    expected: #[
        properties: #[
            A: ["t = t and n = n"]
        ]
        children: []
    ]
    function: "parse-sgf"
    uuid: "25abf1a4-5205-46f1-8c72-53273b94d009"
] #[
    description: {mixing various kinds of whitespace and escaped characters in property value}
    input: #[
        encoded: {(;A[\]b^/c\^/d^-^-e\\ \^/\]])}
    ]
    expected: #[
        properties: #[
            A: ["]b^/cd  e\ ]"]
        ]
        children: []
    ]
    function: "parse-sgf"
    uuid: "08e4b8ba-bb07-4431-a3d9-b1f4cdea6dab"
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
