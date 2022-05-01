Red [
	description: {Tests for "Run Length Encoding" Exercism exercise}
	author: "loziniak"
]

#include %testlib.red

test-init/limit %run-length-encoding.red 1
; test-init/limit %.meta/example.red 1						; test example solution

canonical-cases: [#(
    description: "empty string"
    input: #(
        string: ""
    )
    expected: ""
    function: "encode"
    uuid: "ad53b61b-6ffc-422f-81a6-61f7df92a231"
) #(
    description: "single characters only are encoded without count"
    input: #(
        string: "XYZ"
    )
    expected: "XYZ"
    function: "encode"
    uuid: "52012823-b7e6-4277-893c-5b96d42f82de"
) #(
    description: "string with no single characters"
    input: #(
        string: "AABBBCCCC"
    )
    expected: "2A3B4C"
    function: "encode"
    uuid: "b7868492-7e3a-415f-8da3-d88f51f80409"
) #(
    description: "single characters mixed with repeated characters"
    input: #(
        string: {WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB}
    )
    expected: "12WB12W3B24WB"
    function: "encode"
    uuid: "859b822b-6e9f-44d6-9c46-6091ee6ae358"
) #(
    description: "multiple whitespace mixed in string"
    input: #(
        string: "  hsqq qww  "
    )
    expected: "2 hs2q q2w2 "
    function: "encode"
    uuid: "1b34de62-e152-47be-bc88-469746df63b3"
) #(
    description: "lowercase characters"
    input: #(
        string: "aabbbcccc"
    )
    expected: "2a3b4c"
    function: "encode"
    uuid: "abf176e2-3fbd-40ad-bb2f-2dd6d4df721a"
) #(
    description: "empty string"
    input: #(
        string: ""
    )
    expected: ""
    function: "decode"
    uuid: "7ec5c390-f03c-4acf-ac29-5f65861cdeb5"
) #(
    description: "single characters only"
    input: #(
        string: "XYZ"
    )
    expected: "XYZ"
    function: "decode"
    uuid: "ad23f455-1ac2-4b0e-87d0-b85b10696098"
) #(
    description: "string with no single characters"
    input: #(
        string: "2A3B4C"
    )
    expected: "AABBBCCCC"
    function: "decode"
    uuid: "21e37583-5a20-4a0e-826c-3dee2c375f54"
) #(
    description: "single characters with repeated characters"
    input: #(
        string: "12WB12W3B24WB"
    )
    expected: {WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB}
    function: "decode"
    uuid: "1389ad09-c3a8-4813-9324-99363fba429c"
) #(
    description: "multiple whitespace mixed in string"
    input: #(
        string: "2 hs2q q2w2 "
    )
    expected: "  hsqq qww  "
    function: "decode"
    uuid: "3f8e3c51-6aca-4670-b86c-a213bf4706b0"
) #(
    description: "lowercase string"
    input: #(
        string: "2a3b4c"
    )
    expected: "aabbbcccc"
    function: "decode"
    uuid: "29f721de-9aad-435f-ba37-7662df4fb551"
)]


foreach c-case canonical-cases [
	case-code: reduce [
		'expect c-case/expected compose [
			(to word! c-case/function) (values-of c-case/input)
		] 
	]

	test c-case/description case-code
]

test "encode followed by decode gives original string" [
    expect "zzz ZZ  zZ" [decode encode "zzz ZZ  zZ"]
]

test-results/print
