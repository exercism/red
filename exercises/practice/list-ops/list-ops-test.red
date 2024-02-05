Red [
	description: {Tests for "List Ops" Exercism exercise}
	author: "loziniak"
]

#include %testlib.red

test-init/limit %list-ops.red 1
; test-init/limit %.meta/example.red 1						; test example solution

addone: function [x] [add x 1]
reduce_add: function [acc el] [add el acc]
reduce_multiply: function [acc el] [el * acc]
reduce_divide: function [acc el] [divide el acc]

canonical-cases: [#(
    description: "append -> empty lists"
    input: #(
        list1: []
        list2: []
    )
    expected: []
    function: "append"
    uuid: "485b9452-bf94-40f7-a3db-c3cf4850066a"
) #(
    description: "append -> list to empty list"
    input: #(
        list1: []
        list2: [1 2 3 4]
    )
    expected: [1 2 3 4]
    function: "append"
    uuid: "2c894696-b609-4569-b149-8672134d340a"
) #(
    description: "append -> empty list to list"
    input: #(
        list1: [1 2 3 4]
        list2: []
    )
    expected: [1 2 3 4]
    function: "append"
    uuid: "e842efed-3bf6-4295-b371-4d67a4fdf19c"
) #(
    description: "append -> non-empty lists"
    input: #(
        list1: [1 2]
        list2: [2 3 4 5]
    )
    expected: [1 2 2 3 4 5]
    function: "append"
    uuid: "71dcf5eb-73ae-4a0e-b744-a52ee387922f"
) #(
    description: "concat -> empty list"
    input: #(
        lists: []
    )
    expected: []
    function: "concat"
    uuid: "28444355-201b-4af2-a2f6-5550227bde21"
) #(
    description: "concat -> list of lists"
    input: #(
        lists: [[1 2] [3] [] [4 5 6]]
    )
    expected: [1 2 3 4 5 6]
    function: "concat"
    uuid: "331451c1-9573-42a1-9869-2d06e3b389a9"
) #(
    description: "concat -> list of nested lists"
    input: #(
        lists: [[[1] [2]] [[3]] [[]] [[4 5 6]]]
    )
    expected: [[1] [2] [3] [] [4 5 6]]
    function: "concat"
    uuid: "d6ecd72c-197f-40c3-89a4-aa1f45827e09"
) #(
    description: "filter -> empty list"
    input: #(
        list: []
        f: odd?
    )
    expected: []
    function: "filter"
    uuid: "0524fba8-3e0f-4531-ad2b-f7a43da86a16"
) #(
    description: "filter -> non-empty list"
    input: #(
        list: [1 2 3 5]
        f: odd?
    )
    expected: [1 3 5]
    function: "filter"
    uuid: "88494bd5-f520-4edb-8631-88e415b62d24"
) #(
    description: "length -> empty list"
    input: #(
        list: []
    )
    expected: 0
    function: "length"
    uuid: "1cf0b92d-8d96-41d5-9c21-7b3c37cb6aad"
) #(
    description: "length -> non-empty list"
    input: #(
        list: [1 2 3 4]
    )
    expected: 4
    function: "length"
    uuid: "d7b8d2d9-2d16-44c4-9a19-6e5f237cb71e"
) #(
    description: "map -> empty list"
    input: #(
        list: []
        f: addone
    )
    expected: []
    function: "map"
    uuid: "c0bc8962-30e2-4bec-9ae4-668b8ecd75aa"
) #(
    description: "map -> non-empty list"
    input: #(
        list: [1 3 5 7]
        f: addone
    )
    expected: [2 4 6 8]
    function: "map"
    uuid: "11e71a95-e78b-4909-b8e4-60cdcaec0e91"
) #(
    description: "foldl -> empty list"
    input: #(
        list: []
        initial: 2
        f: reduce_multiply
    )
    expected: 2
    function: "foldl"
    uuid: "36549237-f765-4a4c-bfd9-5d3a8f7b07d2"
) #(
    description: "foldl -> direction independent function applied to non-empty list"
    input: #(
        list: [1 2 3 4]
        initial: 5
        f: reduce_add
    )
    expected: 15
    function: "foldl"
    uuid: "7a626a3c-03ec-42bc-9840-53f280e13067"
) #(
    description: "foldl -> direction dependent function applied to non-empty list"
    input: #(
        list: [1 2 3 4]
        initial: 24
        f: reduce_divide
    )
    expected: 64
    function: "foldl"
    uuid: "d7fcad99-e88e-40e1-a539-4c519681f390"
) #(
    description: "foldr -> empty list"
    input: #(
        list: []
        initial: 2
        f: reduce_multiply
    )
    expected: 2
    function: "foldr"
    uuid: "17214edb-20ba-42fc-bda8-000a5ab525b0"
) #(
    description: "foldr -> direction independent function applied to non-empty list"
    input: #(
        list: [1 2 3 4]
        initial: 5
        f: reduce_add
    )
    expected: 15
    function: "foldr"
    uuid: "e1c64db7-9253-4a3d-a7c4-5273b9e2a1bd"
) #(
    description: "foldr -> direction dependent function applied to non-empty list"
    input: #(
        list: [1 2 3 4]
        initial: 24
        f: reduce_divide
    )
    expected: 9
    function: "foldr"
    uuid: "8066003b-f2ff-437e-9103-66e6df474844"
) #(
    description: "reverse -> empty list"
    input: #(
        list: []
    )
    expected: []
    function: "reverse"
    uuid: "94231515-050e-4841-943d-d4488ab4ee30"
) #(
    description: "reverse -> non-empty list"
    input: #(
        list: [1 3 5 7]
    )
    expected: [7 5 3 1]
    function: "reverse"
    uuid: "fcc03d1e-42e0-4712-b689-d54ad761f360"
) #(
    description: "reverse -> list of lists is not flattened"
    input: #(
        list: [[1 2] [3] [] [4 5 6]]
    )
    expected: [[4 5 6] [] [3] [1 2]]
    function: "reverse"
    uuid: "40872990-b5b8-4cb8-9085-d91fc0d05d26"
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
