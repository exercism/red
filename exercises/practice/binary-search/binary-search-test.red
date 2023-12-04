Red [
	description: {Tests for "Binary Search" Exercism exercise}
	author: "loziniak"
]

#include %testlib.red

test-init/limit %binary-search.red 1
; test-init/limit %.meta/example.red 1						; test example solution

canonical-cases: [#(
    description: "finds a value in an array with one element"
    input: #(
        array: [6]
        value: 6
    )
    expected: 1
    function: "find"
    uuid: "b55c24a9-a98d-4379-a08c-2adcf8ebeee8"
) #(
    description: "finds a value in the middle of an array"
    input: #(
        array: [1 3 4 6 8 9 11]
        value: 6
    )
    expected: 4
    function: "find"
    uuid: "73469346-b0a0-4011-89bf-989e443d503d"
) #(
    description: "finds a value at the beginning of an array"
    input: #(
        array: [1 3 4 6 8 9 11]
        value: 1
    )
    expected: 1
    function: "find"
    uuid: "327bc482-ab85-424e-a724-fb4658e66ddb"
) #(
    description: "finds a value at the end of an array"
    input: #(
        array: [1 3 4 6 8 9 11]
        value: 11
    )
    expected: 7
    function: "find"
    uuid: "f9f94b16-fe5e-472c-85ea-c513804c7d59"
) #(
    description: "finds a value in an array of odd length"
    input: #(
        array: [1 3 5 8 13 21 34 55 89 144 233 377 634]
        value: 144
    )
    expected: 10
    function: "find"
    uuid: "f0068905-26e3-4342-856d-ad153cadb338"
) #(
    description: "finds a value in an array of even length"
    input: #(
        array: [1 3 5 8 13 21 34 55 89 144 233 377]
        value: 21
    )
    expected: 6
    function: "find"
    uuid: "fc316b12-c8b3-4f5e-9e89-532b3389de8c"
) #(
    description: {identifies that a value is not included in the array}
    input: #(
        array: [1 3 4 6 8 9 11]
        value: 7
    )
    expected: #(
        error: "value not in array"
    )
    function: "find"
    uuid: "da7db20a-354f-49f7-a6a1-650a54998aa6"
) #(
    description: {a value smaller than the array's smallest value is not found}
    input: #(
        array: [1 3 4 6 8 9 11]
        value: 0
    )
    expected: #(
        error: "value not in array"
    )
    function: "find"
    uuid: "95d869ff-3daf-4c79-b622-6e805c675f97"
) #(
    description: {a value larger than the array's largest value is not found}
    input: #(
        array: [1 3 4 6 8 9 11]
        value: 13
    )
    expected: #(
        error: "value not in array"
    )
    function: "find"
    uuid: "8b24ef45-6e51-4a94-9eac-c2bf38fdb0ba"
) #(
    description: "nothing is found in an empty array"
    input: #(
        array: []
        value: 1
    )
    expected: #(
        error: "value not in array"
    )
    function: "find"
    uuid: "f439a0fa-cf42-4262-8ad1-64bf41ce566a"
) #(
    description: {nothing is found when the left and right bounds cross}
    input: #(
        array: [1 2]
        value: 0
    )
    expected: #(
        error: "value not in array"
    )
    function: "find"
    uuid: "2c353967-b56d-40b8-acff-ce43115eed64"
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
