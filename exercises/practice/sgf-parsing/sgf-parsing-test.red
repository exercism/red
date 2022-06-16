Red [
	description: {Tests for SGF Parsing Exercism exercise}
	author: "loziniak"
]

exercise-slug: "sgf-parsing"
ignore-after: either empty? system/script/args [1][load system/script/args]


canonical-cases: [#(
    description: "empty input"
    input: #(
        encoded: ""
    )
    expected: #(
        error: "tree missing"
    )
    function: "parse-sgf"
    uuid: "2668d5dc-109f-4f71-b9d5-8d06b1d6f1cd"
) #(
    description: "tree with no nodes"
    input: #(
        encoded: "()"
    )
    expected: #(
        error: "tree with no nodes"
    )
    function: "parse-sgf"
    uuid: "84ded10a-94df-4a30-9457-b50ccbdca813"
) #(
    description: "node without tree"
    input: #(
        encoded: ";"
    )
    expected: #(
        error: "tree missing"
    )
    function: "parse-sgf"
    uuid: "0a6311b2-c615-4fa7-800e-1b1cbb68833d"
) #(
    description: "node without properties"
    input: #(
        encoded: "(;)"
    )
    expected: #(
        properties: #()
        children: []
    )
    function: "parse-sgf"
    uuid: "8c419ed8-28c4-49f6-8f2d-433e706110ef"
) #(
    description: "single node tree"
    input: #(
        encoded: "(;A[B])"
    )
    expected: #(
        properties: #(
            A: ["B"]
        )
        children: []
    )
    function: "parse-sgf"
    uuid: "8209645f-32da-48fe-8e8f-b9b562c26b49"
) #(
    description: "multiple properties"
    input: #(
        encoded: "(;A[b]C[d])"
    )
    expected: #(
        properties: #(
            A: ["b"]
            C: ["d"]
        )
        children: []
    )
    function: "parse-sgf"
    uuid: "6c995856-b919-4c75-8fd6-c2c3c31b37dc"
) #(
    description: "properties without delimiter"
    input: #(
        encoded: "(;A)"
    )
    expected: #(
        error: "properties without delimiter"
    )
    function: "parse-sgf"
    uuid: "a771f518-ec96-48ca-83c7-f8d39975645f"
) #(
    description: "all lowercase property"
    input: #(
        encoded: "(;a[b])"
    )
    expected: #(
        error: "property must be in uppercase"
    )
    function: "parse-sgf"
    uuid: "6c02a24e-6323-4ed5-9962-187d19e36bc8"
) #(
    description: "upper and lowercase property"
    input: #(
        encoded: "(;Aa[b])"
    )
    expected: #(
        error: "property must be in uppercase"
    )
    function: "parse-sgf"
    uuid: "8772d2b1-3c57-405a-93ac-0703b671adc1"
) #(
    description: "two nodes"
    input: #(
        encoded: "(;A[B];B[C])"
    )
    expected: #(
        properties: #(
            A: ["B"]
        )
        children: [#(
            properties: #(
                B: ["C"]
            )
            children: []
        )]
    )
    function: "parse-sgf"
    uuid: "a759b652-240e-42ec-a6d2-3a08d834b9e2"
) #(
    description: "two child trees"
    input: #(
        encoded: "(;A[B](;B[C])(;C[D]))"
    )
    expected: #(
        properties: #(
            A: ["B"]
        )
        children: [#(
            properties: #(
                B: ["C"]
            )
            children: []
        ) #(
            properties: #(
                C: ["D"]
            )
            children: []
        )]
    )
    function: "parse-sgf"
    uuid: "cc7c02bc-6097-42c4-ab88-a07cb1533d00"
) #(
    description: "multiple property values"
    input: #(
        encoded: "(;A[b][c][d])"
    )
    expected: #(
        properties: #(
            A: ["b" "c" "d"]
        )
        children: []
    )
    function: "parse-sgf"
    uuid: "724eeda6-00db-41b1-8aa9-4d5238ca0130"
) #(
    description: "escaped property"
    input: #(
        encoded: "(;A[\]b\nc\nd\t\te \n\]])"
    )
    expected: #(
        properties: #(
            A: ["]b\nc\nd  e \n]"]
        )
        children: []
    )
    function: "parse-sgf"
    uuid: "11c36323-93fc-495d-bb23-c88ee5844b8c"
)]

check-result: function [result expected][
    if expected/error [
        if not error? result [
            print ["error expected: " expected/error]
            print ["instead got: " mold result]
            print [{You can create an error like this with `do make error! "} expected/error {"'}]
            return 'errored
        ]
        if expected/error <> result/arg1 [
            print [{wrong error was produced.}]
            print [{error expected:} expected/error]
            print [{instead got:} result/arg1]
            return 'errored
        ]
        return problems: none
    ]

    if error? result [
        print [{unexpected error:} form result]
        print [{expected value:} expected]
        return 'errored
    ]
    
    if result <> expected [
        print [{incorrect output:}]
        print [mold result]
        print [{expected:}]
        print [mold expected]
        return 'errored
    ]

    unexpected-results: none
]

print ["Testing" ignore-after "cases…"]

cases: copy/deep/part canonical-cases ignore-after
foreach test-case cases [
	result: context load to file!
		rejoin [exercise-slug %.red]
	;	%.meta/example.red						; test example solution

	; function name
	result-execution: reduce [
		make path! reduce [
			'result
			to word! test-case/function
		]
	]
	; arguments
	append result-execution values-of test-case/input

	result: try [do result-execution]
    expected: test-case/expected

    errors: check-result result expected

	print [
		pad/with test-case/description 30 #"."
		either errors [{FAILED.}]["✓"]
	]
]

print [
	(length? canonical-cases) - ignore-after
	"cases ignored."
]
