Red [
	description: {Tests for "Flower Field" Exercism exercise}
	author: "loziniak"
]

#include %testlib.red

test-init/limit %flower-field.red 1
; test-init/limit %.meta/example.red 1						; test example solution

canonical-cases: [#[
    description: "no rows"
    input: #[
        garden: []
    ]
    expected: []
    function: "annotate"
    uuid: "237ff487-467a-47e1-9b01-8a891844f86c"
] #[
    description: "no columns"
    input: #[
        garden: [""]
    ]
    expected: [""]
    function: "annotate"
    uuid: "4b4134ec-e20f-439c-a295-664c38950ba1"
] #[
    description: "no flowers"
    input: #[
        garden: ["   " "   " "   "]
    ]
    expected: ["   " "   " "   "]
    function: "annotate"
    uuid: "d774d054-bbad-4867-88ae-069cbd1c4f92"
] #[
    description: "garden full of flowers"
    input: #[
        garden: ["***" "***" "***"]
    ]
    expected: ["***" "***" "***"]
    function: "annotate"
    uuid: "225176a0-725e-43cd-aa13-9dced501f16e"
] #[
    description: "flower surrounded by spaces"
    input: #[
        garden: ["   " " * " "   "]
    ]
    expected: ["111" "1*1" "111"]
    function: "annotate"
    uuid: "3f345495-f1a5-4132-8411-74bd7ca08c49"
] #[
    description: "space surrounded by flowers"
    input: #[
        garden: ["***" "* *" "***"]
    ]
    expected: ["***" "*8*" "***"]
    function: "annotate"
    uuid: "6cb04070-4199-4ef7-a6fa-92f68c660fca"
] #[
    description: "horizontal line"
    input: #[
        garden: [" * * "]
    ]
    expected: ["1*2*1"]
    function: "annotate"
    uuid: "272d2306-9f62-44fe-8ab5-6b0f43a26338"
] #[
    description: "horizontal line, flowers at edges"
    input: #[
        garden: ["*   *"]
    ]
    expected: ["*1 1*"]
    function: "annotate"
    uuid: "c6f0a4b2-58d0-4bf6-ad8d-ccf4144f1f8e"
] #[
    description: "vertical line"
    input: #[
        garden: [" " "*" " " "*" " "]
    ]
    expected: ["1" "*" "2" "*" "1"]
    function: "annotate"
    uuid: "a54e84b7-3b25-44a8-b8cf-1753c8bb4cf5"
] #[
    description: "vertical line, flowers at edges"
    input: #[
        garden: ["*" " " " " " " "*"]
    ]
    expected: ["*" "1" " " "1" "*"]
    function: "annotate"
    uuid: "b40f42f5-dec5-4abc-b167-3f08195189c1"
] #[
    description: "cross"
    input: #[
        garden: ["  *  " "  *  " "*****" "  *  " "  *  "]
    ]
    expected: [" 2*2 " "25*52" "*****" "25*52" " 2*2 "]
    function: "annotate"
    uuid: "58674965-7b42-4818-b930-0215062d543c"
] #[
    description: "large garden"
    input: #[
        garden: [" *  * " "  *   " "    * " "   * *" " *  * " "      "]
    ]
    expected: ["1*22*1" "12*322" " 123*2" "112*4*" "1*22*2" "111111"]
    function: "annotate"
    uuid: "dd9d4ca8-9e68-4f78-a677-a2a70fd7a7b8"
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
