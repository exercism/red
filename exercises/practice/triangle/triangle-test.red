Red [
	description: {Tests for "Triangle" Exercism exercise}
	author: "loziniak"
]

#include %testlib.red

test-init/limit %triangle.red 1
; test-init/limit %.meta/example.red 1						; test example solution

canonical-cases: [#(
    description: "all sides are equal"
    input: #(
        sides: [2 2 2]
    )
    expected: true
    function: "equilateral"
    uuid: "8b2c43ac-7257-43f9-b552-7631a91988af"
) #(
    description: "any side is unequal"
    input: #(
        sides: [2 3 2]
    )
    expected: false
    function: "equilateral"
    uuid: "33eb6f87-0498-4ccf-9573-7f8c3ce92b7b"
) #(
    description: "no sides are equal"
    input: #(
        sides: [5 4 6]
    )
    expected: false
    function: "equilateral"
    uuid: "c6585b7d-a8c0-4ad8-8a34-e21d36f7ad87"
) #(
    description: "all zero sides is not a triangle"
    input: #(
        sides: [0 0 0]
    )
    expected: false
    function: "equilateral"
    uuid: "16e8ceb0-eadb-46d1-b892-c50327479251"
) #(
    description: "sides may be floats"
    input: #(
        sides: [0.5 0.5 0.5]
    )
    expected: true
    function: "equilateral"
    uuid: "3022f537-b8e5-4cc1-8f12-fd775827a00c"
) #(
    description: "last two sides are equal"
    input: #(
        sides: [3 4 4]
    )
    expected: true
    function: "isosceles"
    uuid: "cbc612dc-d75a-4c1c-87fc-e2d5edd70b71"
) #(
    description: "first two sides are equal"
    input: #(
        sides: [4 4 3]
    )
    expected: true
    function: "isosceles"
    uuid: "e388ce93-f25e-4daf-b977-4b7ede992217"
) #(
    description: "first and last sides are equal"
    input: #(
        sides: [4 3 4]
    )
    expected: true
    function: "isosceles"
    uuid: "d2080b79-4523-4c3f-9d42-2da6e81ab30f"
) #(
    description: "equilateral triangles are also isosceles"
    input: #(
        sides: [4 4 4]
    )
    expected: true
    function: "isosceles"
    uuid: "8d71e185-2bd7-4841-b7e1-71689a5491d8"
) #(
    description: "no sides are equal"
    input: #(
        sides: [2 3 4]
    )
    expected: false
    function: "isosceles"
    uuid: "840ed5f8-366f-43c5-ac69-8f05e6f10bbb"
) #(
    description: "first triangle inequality violation"
    input: #(
        sides: [1 1 3]
    )
    expected: false
    function: "isosceles"
    uuid: "2eba0cfb-6c65-4c40-8146-30b608905eae"
) #(
    description: "second triangle inequality violation"
    input: #(
        sides: [1 3 1]
    )
    expected: false
    function: "isosceles"
    uuid: "278469cb-ac6b-41f0-81d4-66d9b828f8ac"
) #(
    description: "third triangle inequality violation"
    input: #(
        sides: [3 1 1]
    )
    expected: false
    function: "isosceles"
    uuid: "90efb0c7-72bb-4514-b320-3a3892e278ff"
) #(
    description: "sides may be floats"
    input: #(
        sides: [0.5 0.4 0.5]
    )
    expected: true
    function: "isosceles"
    uuid: "adb4ee20-532f-43dc-8d31-e9271b7ef2bc"
) #(
    description: "no sides are equal"
    input: #(
        sides: [5 4 6]
    )
    expected: true
    function: "scalene"
    uuid: "e8b5f09c-ec2e-47c1-abec-f35095733afb"
) #(
    description: "all sides are equal"
    input: #(
        sides: [4 4 4]
    )
    expected: false
    function: "scalene"
    uuid: "2510001f-b44d-4d18-9872-2303e7977dc1"
) #(
    description: "first and second sides are equal"
    input: #(
        sides: [4 4 3]
    )
    expected: false
    function: "scalene"
    uuid: "c6e15a92-90d9-4fb3-90a2-eef64f8d3e1e"
) #(
    description: "first and third sides are equal"
    input: #(
        sides: [3 4 3]
    )
    expected: false
    function: "scalene"
    uuid: "3da23a91-a166-419a-9abf-baf4868fd985"
) #(
    description: "second and third sides are equal"
    input: #(
        sides: [4 3 3]
    )
    expected: false
    function: "scalene"
    uuid: "b6a75d98-1fef-4c42-8e9a-9db854ba0a4d"
) #(
    description: "may not violate triangle inequality"
    input: #(
        sides: [7 3 2]
    )
    expected: false
    function: "scalene"
    uuid: "70ad5154-0033-48b7-af2c-b8d739cd9fdc"
) #(
    description: "sides may be floats"
    input: #(
        sides: [0.5 0.4 0.6]
    )
    expected: true
    function: "scalene"
    uuid: "26d9d59d-f8f1-40d3-ad58-ae4d54123d7d"
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
