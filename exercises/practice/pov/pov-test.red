Red [
	description: {Tests for "POV" Exercism exercise}
	author: "loziniak"
]

#include %testlib.red

test-init/limit %pov.red 1
; test-init/limit %.meta/example.red 15						; test example solution

canonical-cases: [#(
    description: {Results in the same tree if the input tree is a singleton}
    input: #(
        tree: #(
            label: "x"
        )
        from: "x"
    )
    expected: #(
        label: "x"
    )
    function: "from-pov"
    uuid: "1b3cd134-49ad-4a7d-8376-7087b7e70792"
) #(
    description: "Can reroot a tree with a parent and one sibling"
    input: #(
        tree: #(
            label: "parent"
            children: [#(
                label: "x"
            ) #(
                label: "sibling"
            )]
        )
        from: "x"
    )
    expected: #(
        label: "x"
        children: [#(
            label: "parent"
            children: [#(
                label: "sibling"
            )]
        )]
    )
    function: "from-pov"
    uuid: "0778c745-0636-40de-9edd-25a8f40426f6"
) #(
    description: "Can reroot a tree with a parent and many siblings"
    input: #(
        tree: #(
            label: "parent"
            children: [#(
                label: "a"
            ) #(
                label: "x"
            ) #(
                label: "b"
            ) #(
                label: "c"
            )]
        )
        from: "x"
    )
    expected: #(
        label: "x"
        children: [#(
            label: "parent"
            children: [#(
                label: "a"
            ) #(
                label: "b"
            ) #(
                label: "c"
            )]
        )]
    )
    function: "from-pov"
    uuid: "fdfdef0a-4472-4248-8bcf-19cf33f9c06e"
) #(
    description: {Can reroot a tree with new root deeply nested in tree}
    input: #(
        tree: #(
            label: "level-0"
            children: [#(
                label: "level-1"
                children: [#(
                    label: "level-2"
                    children: [#(
                        label: "level-3"
                        children: [#(
                            label: "x"
                        )]
                    )]
                )]
            )]
        )
        from: "x"
    )
    expected: #(
        label: "x"
        children: [#(
            label: "level-3"
            children: [#(
                label: "level-2"
                children: [#(
                    label: "level-1"
                    children: [#(
                        label: "level-0"
                    )]
                )]
            )]
        )]
    )
    function: "from-pov"
    uuid: "cbcf52db-8667-43d8-a766-5d80cb41b4bb"
) #(
    description: {Moves children of the new root to same level as former parent}
    input: #(
        tree: #(
            label: "parent"
            children: [#(
                label: "x"
                children: [#(
                    label: "kid-0"
                ) #(
                    label: "kid-1"
                )]
            )]
        )
        from: "x"
    )
    expected: #(
        label: "x"
        children: [#(
            label: "kid-0"
        ) #(
            label: "kid-1"
        ) #(
            label: "parent"
        )]
    )
    function: "from-pov"
    uuid: "e27fa4fa-648d-44cd-90af-d64a13d95e06"
) #(
    description: "Can reroot a complex tree with cousins"
    input: #(
        tree: #(
            label: "grandparent"
            children: [#(
                label: "parent"
                children: [#(
                    label: "x"
                    children: [#(
                        label: "kid-0"
                    ) #(
                        label: "kid-1"
                    )]
                ) #(
                    label: "sibling-0"
                ) #(
                    label: "sibling-1"
                )]
            ) #(
                label: "uncle"
                children: [#(
                    label: "cousin-0"
                ) #(
                    label: "cousin-1"
                )]
            )]
        )
        from: "x"
    )
    expected: #(
        label: "x"
        children: [#(
            label: "kid-0"
        ) #(
            label: "kid-1"
        ) #(
            label: "parent"
            children: [#(
                label: "sibling-0"
            ) #(
                label: "sibling-1"
            ) #(
                label: "grandparent"
                children: [#(
                    label: "uncle"
                    children: [#(
                        label: "cousin-0"
                    ) #(
                        label: "cousin-1"
                    )]
                )]
            )]
        )]
    )
    function: "from-pov"
    uuid: "09236c7f-7c83-42cc-87a1-25afa60454a3"
) #(
    description: {Errors if target does not exist in a singleton tree}
    input: #(
        tree: #(
            label: "x"
        )
        from: "nonexistent"
    )
    expected: none
    function: "from-pov"
    uuid: "f41d5eeb-8973-448f-a3b0-cc1e019a4193"
) #(
    description: "Errors if target does not exist in a large tree"
    input: #(
        tree: #(
            label: "parent"
            children: [#(
                label: "x"
                children: [#(
                    label: "kid-0"
                ) #(
                    label: "kid-1"
                )]
            ) #(
                label: "sibling-0"
            ) #(
                label: "sibling-1"
            )]
        )
        from: "nonexistent"
    )
    expected: none
    function: "from-pov"
    uuid: "9dc0a8b3-df02-4267-9a41-693b6aff75e7"
) #(
    description: "Can find path to parent"
    input: #(
        from: "x"
        to: "parent"
        tree: #(
            label: "parent"
            children: [#(
                label: "x"
            ) #(
                label: "sibling"
            )]
        )
    )
    expected: ["x" "parent"]
    function: "path-to"
    uuid: "02d1f1d9-428d-4395-b026-2db35ffa8f0a"
) #(
    description: "Can find path to sibling"
    input: #(
        from: "x"
        to: "b"
        tree: #(
            label: "parent"
            children: [#(
                label: "a"
            ) #(
                label: "x"
            ) #(
                label: "b"
            ) #(
                label: "c"
            )]
        )
    )
    expected: ["x" "parent" "b"]
    function: "path-to"
    uuid: "d0002674-fcfb-4cdc-9efa-bfc54e3c31b5"
) #(
    description: "Can find path to cousin"
    input: #(
        from: "x"
        to: "cousin-1"
        tree: #(
            label: "grandparent"
            children: [#(
                label: "parent"
                children: [#(
                    label: "x"
                    children: [#(
                        label: "kid-0"
                    ) #(
                        label: "kid-1"
                    )]
                ) #(
                    label: "sibling-0"
                ) #(
                    label: "sibling-1"
                )]
            ) #(
                label: "uncle"
                children: [#(
                    label: "cousin-0"
                ) #(
                    label: "cousin-1"
                )]
            )]
        )
    )
    expected: ["x" "parent" "grandparent" "uncle" "cousin-1"]
    function: "path-to"
    uuid: "c9877cd1-0a69-40d4-b362-725763a5c38f"
) #(
    description: "Can find path not involving root"
    input: #(
        from: "x"
        to: "sibling-1"
        tree: #(
            label: "grandparent"
            children: [#(
                label: "parent"
                children: [#(
                    label: "x"
                ) #(
                    label: "sibling-0"
                ) #(
                    label: "sibling-1"
                )]
            )]
        )
    )
    expected: ["x" "parent" "sibling-1"]
    function: "path-to"
    uuid: "9fb17a82-2c14-4261-baa3-2f3f234ffa03"
) #(
    description: "Can find path from nodes other than x"
    input: #(
        from: "a"
        to: "c"
        tree: #(
            label: "parent"
            children: [#(
                label: "a"
            ) #(
                label: "x"
            ) #(
                label: "b"
            ) #(
                label: "c"
            )]
        )
    )
    expected: ["a" "parent" "c"]
    function: "path-to"
    uuid: "5124ed49-7845-46ad-bc32-97d5ac7451b2"
) #(
    description: "Errors if destination does not exist"
    input: #(
        from: "x"
        to: "nonexistent"
        tree: #(
            label: "parent"
            children: [#(
                label: "x"
                children: [#(
                    label: "kid-0"
                ) #(
                    label: "kid-1"
                )]
            ) #(
                label: "sibling-0"
            ) #(
                label: "sibling-1"
            )]
        )
    )
    expected: none
    function: "path-to"
    uuid: "f52a183c-25cc-4c87-9fc9-0e7f81a5725c"
) #(
    description: "Errors if source does not exist"
    input: #(
        from: "nonexistent"
        to: "x"
        tree: #(
            label: "parent"
            children: [#(
                label: "x"
                children: [#(
                    label: "kid-0"
                ) #(
                    label: "kid-1"
                )]
            ) #(
                label: "sibling-0"
            ) #(
                label: "sibling-1"
            )]
        )
    )
    expected: none
    function: "path-to"
    uuid: "f4fe18b9-b4a2-4bd5-a694-e179155c2149"
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
