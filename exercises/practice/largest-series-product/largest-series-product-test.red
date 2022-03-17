Red [
	description: {Tests for Largest Series Product Exercism exercise}
	author: "loziniak"
]

#include %testlib.red

test-init/limit %largest-series-product.red 1
; test-init/limit %.meta/example.red 1						; test example solution

canonical-cases: [#(
    description: "finds the largest product if span equals length"
    input: #(
        digits: "29"
        span: 2
    )
    expected: 18
    function: "largest-product"
    uuid: "7c82f8b7-e347-48ee-8a22-f672323324d4"
) #(
    description: {can find the largest product of 2 with numbers in order}
    input: #(
        digits: "0123456789"
        span: 2
    )
    expected: 72
    function: "largest-product"
    uuid: "88523f65-21ba-4458-a76a-b4aaf6e4cb5e"
) #(
    description: "can find the largest product of 2"
    input: #(
        digits: "576802143"
        span: 2
    )
    expected: 48
    function: "largest-product"
    uuid: "f1376b48-1157-419d-92c2-1d7e36a70b8a"
) #(
    description: {can find the largest product of 3 with numbers in order}
    input: #(
        digits: "0123456789"
        span: 3
    )
    expected: 504
    function: "largest-product"
    uuid: "46356a67-7e02-489e-8fea-321c2fa7b4a4"
) #(
    description: "can find the largest product of 3"
    input: #(
        digits: "1027839564"
        span: 3
    )
    expected: 270
    function: "largest-product"
    uuid: "a2dcb54b-2b8f-4993-92dd-5ce56dece64a"
) #(
    description: {can find the largest product of 5 with numbers in order}
    input: #(
        digits: "0123456789"
        span: 5
    )
    expected: 15120
    function: "largest-product"
    uuid: "673210a3-33cd-4708-940b-c482d7a88f9d"
) #(
    description: "can get the largest product of a big number"
    input: #(
        digits: {73167176531330624919225119674426574742355349194934}
        span: 6
    )
    expected: 23520
    function: "largest-product"
    uuid: "02acd5a6-3bbf-46df-8282-8b313a80a7c9"
) #(
    description: "reports zero if the only digits are zero"
    input: #(
        digits: "0000"
        span: 2
    )
    expected: 0
    function: "largest-product"
    uuid: "76dcc407-21e9-424c-a98e-609f269622b5"
) #(
    description: "reports zero if all spans include zero"
    input: #(
        digits: "99099"
        span: 3
    )
    expected: 0
    function: "largest-product"
    uuid: "6ef0df9f-52d4-4a5d-b210-f6fae5f20e19"
) #(
    description: "rejects span longer than string length"
    input: #(
        digits: "123"
        span: 4
    )
    expected: #(
        error: "span must be smaller than string length"
    )
    function: "largest-product"
    uuid: "5d81aaf7-4f67-4125-bf33-11493cc7eab7"
) #(
    description: {reports 1 for empty string and empty product (0 span)}
    input: #(
        digits: ""
        span: 0
    )
    expected: 1
    function: "largest-product"
    uuid: "06bc8b90-0c51-4c54-ac22-3ec3893a079e"
) #(
    description: {reports 1 for nonempty string and empty product (0 span)}
    input: #(
        digits: "123"
        span: 0
    )
    expected: 1
    function: "largest-product"
    uuid: "3ec0d92e-f2e2-4090-a380-70afee02f4c0"
) #(
    description: "rejects empty string and nonzero span"
    input: #(
        digits: ""
        span: 1
    )
    expected: #(
        error: "span must be smaller than string length"
    )
    function: "largest-product"
    uuid: "6d96c691-4374-4404-80ee-2ea8f3613dd4"
) #(
    description: "rejects invalid character in digits"
    input: #(
        digits: "1234a5"
        span: 2
    )
    expected: #(
        error: "digits input must only contain digits"
    )
    function: "largest-product"
    uuid: "7a38f2d6-3c35-45f6-8d6f-12e6e32d4d74"
) #(
    description: "rejects negative span"
    input: #(
        digits: "12345"
        span: -1
    )
    expected: #(
        error: "span must be greater than zero"
    )
    function: "largest-product"
    uuid: "5fe3c0e5-a945-49f2-b584-f0814b4dd1ef"
)]


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
