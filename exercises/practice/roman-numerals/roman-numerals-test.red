Red [
	description: {Tests for Roman Numerals Exercism exercise}
	author: "loziniak"
]

#include %testlib.red

test-init/limit %roman-numerals.red 1
; test-init/limit %.meta/example.red 1						; test example solution

canonical-cases: [#(
    description: "1 is I"
    input: #(
        number: 1
    )
    expected: "I"
    function: "roman"
    uuid: "19828a3a-fbf7-4661-8ddd-cbaeee0e2178"
) #(
    description: "2 is II"
    input: #(
        number: 2
    )
    expected: "II"
    function: "roman"
    uuid: "f088f064-2d35-4476-9a41-f576da3f7b03"
) #(
    description: "3 is III"
    input: #(
        number: 3
    )
    expected: "III"
    function: "roman"
    uuid: "b374a79c-3bea-43e6-8db8-1286f79c7106"
) #(
    description: "4 is IV"
    input: #(
        number: 4
    )
    expected: "IV"
    function: "roman"
    uuid: "05a0a1d4-a140-4db1-82e8-fcc21fdb49bb"
) #(
    description: "5 is V"
    input: #(
        number: 5
    )
    expected: "V"
    function: "roman"
    uuid: "57c0f9ad-5024-46ab-975d-de18c430b290"
) #(
    description: "6 is VI"
    input: #(
        number: 6
    )
    expected: "VI"
    function: "roman"
    uuid: "20a2b47f-e57f-4797-a541-0b3825d7f249"
) #(
    description: "9 is IX"
    input: #(
        number: 9
    )
    expected: "IX"
    function: "roman"
    uuid: "ff3fb08c-4917-4aab-9f4e-d663491d083d"
) #(
    description: "27 is XXVII"
    input: #(
        number: 27
    )
    expected: "XXVII"
    function: "roman"
    uuid: "2bda64ca-7d28-4c56-b08d-16ce65716cf6"
) #(
    description: "48 is XLVIII"
    input: #(
        number: 48
    )
    expected: "XLVIII"
    function: "roman"
    uuid: "a1f812ef-84da-4e02-b4f0-89c907d0962c"
) #(
    description: "49 is XLIX"
    input: #(
        number: 49
    )
    expected: "XLIX"
    function: "roman"
    uuid: "607ead62-23d6-4c11-a396-ef821e2e5f75"
) #(
    description: "59 is LIX"
    input: #(
        number: 59
    )
    expected: "LIX"
    function: "roman"
    uuid: "d5b283d4-455d-4e68-aacf-add6c4b51915"
) #(
    description: "93 is XCIII"
    input: #(
        number: 93
    )
    expected: "XCIII"
    function: "roman"
    uuid: "46b46e5b-24da-4180-bfe2-2ef30b39d0d0"
) #(
    description: "141 is CXLI"
    input: #(
        number: 141
    )
    expected: "CXLI"
    function: "roman"
    uuid: "30494be1-9afb-4f84-9d71-db9df18b55e3"
) #(
    description: "163 is CLXIII"
    input: #(
        number: 163
    )
    expected: "CLXIII"
    function: "roman"
    uuid: "267f0207-3c55-459a-b81d-67cec7a46ed9"
) #(
    description: "402 is CDII"
    input: #(
        number: 402
    )
    expected: "CDII"
    function: "roman"
    uuid: "cdb06885-4485-4d71-8bfb-c9d0f496b404"
) #(
    description: "575 is DLXXV"
    input: #(
        number: 575
    )
    expected: "DLXXV"
    function: "roman"
    uuid: "6b71841d-13b2-46b4-ba97-dec28133ea80"
) #(
    description: "911 is CMXI"
    input: #(
        number: 911
    )
    expected: "CMXI"
    function: "roman"
    uuid: "432de891-7fd6-4748-a7f6-156082eeca2f"
) #(
    description: "1024 is MXXIV"
    input: #(
        number: 1024
    )
    expected: "MXXIV"
    function: "roman"
    uuid: "e6de6d24-f668-41c0-88d7-889c0254d173"
) #(
    description: "3000 is MMM"
    input: #(
        number: 3000
    )
    expected: "MMM"
    function: "roman"
    uuid: "bb550038-d4eb-4be2-a9ce-f21961ac3bc6"
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
