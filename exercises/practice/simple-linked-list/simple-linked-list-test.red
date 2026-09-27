Red [
	description: {Tests for "Simple Linked List" Exercism exercise}
	author: "loziniak"
]

#include %testlib.red

test-init/limit %simple-linked-list.red 1
; test-init/limit %.meta/example.red 1						; test example solution

operation-code: function [operation [map!]] [
	switch operation/operation [
		"count" [[list-count get 'list]]
		"pop" [[list-pop get 'list]]
		"push" [compose [list-push get 'list (operation/value)]]
		"peek" [[list-peek get 'list]]
		"toList" [[list-to-array get 'list]]
		"reverse" [[list-reverse get 'list]]
	]
]

canonical-cases: [#[
    description: "Empty list has length of zero"
    input: #[
        initialValues: []
        operations: [#[
            operation: "count"
            expected: 0
        ]]
    ]
    expected: #[]
    function: "list"
    uuid: "962d998c-c203-41e2-8fbd-85a7b98b79b9"
] #[
    description: "Singleton list has length of one"
    input: #[
        initialValues: [1]
        operations: [#[
            operation: "count"
            expected: 1
        ]]
    ]
    expected: #[]
    function: "list"
    uuid: "9760262e-d7e4-4639-9840-87e2e2fbb115"
] #[
    description: "Non-empty list has correct length"
    input: #[
        initialValues: [1 2 3]
        operations: [#[
            operation: "count"
            expected: 3
        ]]
    ]
    expected: #[]
    function: "list"
    uuid: "d9955c90-637c-441b-b41d-8cfb48e924a8"
] #[
    description: "Pop from empty list is an error"
    input: #[
        initialValues: []
        operations: [#[
            operation: "pop"
            expected: #[
                error: "list is empty"
            ]
        ]]
    ]
    expected: #[]
    function: "list"
    uuid: "0c3966db-58f9-4632-b94c-8ea13e54c2c8"
] #[
    description: "Can pop from singleton list"
    input: #[
        initialValues: [1]
        operations: [#[
            operation: "pop"
            expected: 1
        ]]
    ]
    expected: #[]
    function: "list"
    uuid: "a4f9d2e1-7425-49ef-9ee8-6c0cb3407cf0"
] #[
    description: "Can pop from non-empty list"
    input: #[
        initialValues: [1 2]
        operations: [#[
            operation: "pop"
            expected: 2
        ]]
    ]
    expected: #[]
    function: "list"
    uuid: "6dcbb2c9-d98a-47bc-a010-9c19703d3ea2"
] #[
    description: "Can pop multiple items"
    input: #[
        initialValues: [1 2]
        operations: [#[
            operation: "pop"
            expected: 2
        ] #[
            operation: "pop"
            expected: 1
        ]]
    ]
    expected: #[]
    function: "list"
    uuid: "e83aade9-f030-4096-aaf0-f9dc6491e6cf"
] #[
    description: "Pop updates the count"
    input: #[
        initialValues: [1 2]
        operations: [#[
            operation: "count"
            expected: 2
        ] #[
            operation: "pop"
            expected: 2
        ] #[
            operation: "count"
            expected: 1
        ] #[
            operation: "pop"
            expected: 1
        ] #[
            operation: "count"
            expected: 0
        ]]
    ]
    expected: #[]
    function: "list"
    uuid: "5c46bcf2-c0a9-4654-ae17-f3192436fcf1"
] #[
    description: "Can push to an empty list"
    input: #[
        initialValues: []
        operations: [#[
            operation: "push"
            value: 1
        ]]
    ]
    expected: #[]
    function: "list"
    uuid: "f3197f0a-1fea-45a5-939f-4a5ea60387ec"
] #[
    description: "Can push to a non-empty list"
    input: #[
        initialValues: [1 2]
        operations: [#[
            operation: "push"
            value: 3
        ]]
    ]
    expected: #[]
    function: "list"
    uuid: "391e332e-1f91-4033-b1e0-0e0c17812fa7"
] #[
    description: "Push updates count"
    input: #[
        initialValues: [1 2]
        operations: [#[
            operation: "push"
            value: 3
        ] #[
            operation: "count"
            expected: 3
        ]]
    ]
    expected: #[]
    function: "list"
    uuid: "ed4b0e01-3bbd-4895-af25-152b5914b3da"
] #[
    description: "Push and pop"
    input: #[
        initialValues: []
        operations: [#[
            operation: "push"
            value: 1
        ] #[
            operation: "push"
            value: 2
        ] #[
            operation: "pop"
            expected: 2
        ] #[
            operation: "push"
            value: 3
        ] #[
            operation: "count"
            expected: 2
        ] #[
            operation: "pop"
            expected: 3
        ] #[
            operation: "pop"
            expected: 1
        ] #[
            operation: "count"
            expected: 0
        ]]
    ]
    expected: #[]
    function: "list"
    uuid: "41666790-b932-4e5a-b323-e848a83d12d5"
] #[
    description: "Peek on empty list is an error"
    input: #[
        initialValues: []
        operations: [#[
            operation: "peek"
            expected: #[
                error: "list is empty"
            ]
        ]]
    ]
    expected: #[]
    function: "list"
    uuid: "930a4a5c-76f6-47ec-9be3-4e70993173a1"
] #[
    description: "Can peek on singleton list"
    input: #[
        initialValues: [1]
        operations: [#[
            operation: "peek"
            expected: 1
        ]]
    ]
    expected: #[]
    function: "list"
    uuid: "43255a50-d919-4e81-afce-e4a271eaedbd"
] #[
    description: "Can peek on non-empty list"
    input: #[
        initialValues: [1 2]
        operations: [#[
            operation: "peek"
            expected: 2
        ]]
    ]
    expected: #[]
    function: "list"
    uuid: "48353020-e25d-4621-a854-e35fb1e15fa7"
] #[
    description: "Peek does not change the count"
    input: #[
        initialValues: [1 2]
        operations: [#[
            operation: "peek"
            expected: 2
        ] #[
            operation: "count"
            expected: 2
        ]]
    ]
    expected: #[]
    function: "list"
    uuid: "96fcead9-a713-46c2-8005-3f246c873851"
] #[
    description: "Can peek after a pop and push"
    input: #[
        initialValues: []
        operations: [#[
            operation: "push"
            value: 1
        ] #[
            operation: "push"
            value: 2
        ] #[
            operation: "peek"
            expected: 2
        ] #[
            operation: "pop"
            expected: 2
        ] #[
            operation: "peek"
            expected: 1
        ] #[
            operation: "push"
            value: 3
        ] #[
            operation: "peek"
            expected: 3
        ]]
    ]
    expected: #[]
    function: "list"
    uuid: "7576ed05-7ff7-4b84-8efb-d34d62c110f5"
] #[
    description: "Empty linked list to list is empty"
    input: #[
        initialValues: []
        operations: [#[
            operation: "toList"
            expected: []
        ]]
    ]
    expected: #[]
    function: "list"
    uuid: "03fc83a5-48a8-470b-a2d2-a286c5e8365f"
] #[
    description: "To list with multiple values"
    input: #[
        initialValues: [1 2 3]
        operations: [#[
            operation: "toList"
            expected: [1 2 3]
        ]]
    ]
    expected: #[]
    function: "list"
    uuid: "1282484e-a58c-426a-972e-90746bda61fc"
] #[
    description: "To list after a pop"
    input: #[
        initialValues: []
        operations: [#[
            operation: "push"
            value: 1
        ] #[
            operation: "push"
            value: 2
        ] #[
            operation: "push"
            value: 3
        ] #[
            operation: "pop"
            expected: 3
        ] #[
            operation: "push"
            value: 4
        ] #[
            operation: "toList"
            expected: [1 2 4]
        ]]
    ]
    expected: #[]
    function: "list"
    uuid: "05ca3109-1249-4c0c-a567-a3b2f8352a7c"
] #[
    description: "Reversed empty list has same values"
    input: #[
        initialValues: []
        operations: [#[
            operation: "reverse"
        ] #[
            operation: "toList"
            expected: []
        ]]
    ]
    expected: #[]
    function: "list"
    uuid: "5e6c1a3d-e34b-46d3-be59-3f132a820ed5"
] #[
    description: "Reversed singleton list is same list"
    input: #[
        initialValues: [1]
        operations: [#[
            operation: "reverse"
        ] #[
            operation: "toList"
            expected: [1]
        ]]
    ]
    expected: #[]
    function: "list"
    uuid: "93c87ed3-862a-474f-820b-ba3fd6b6daf6"
] #[
    description: "Reversed non-empty list is reversed"
    input: #[
        initialValues: [1 2 3]
        operations: [#[
            operation: "reverse"
        ] #[
            operation: "count"
            expected: 3
        ] #[
            operation: "pop"
            expected: 1
        ] #[
            operation: "pop"
            expected: 2
        ] #[
            operation: "pop"
            expected: 3
        ]]
    ]
    expected: #[]
    function: "list"
    uuid: "1210eeda-b23f-4790-930c-7ac6d0c8e723"
] #[
    description: "Double reverse"
    input: #[
        initialValues: [1 2 3]
        operations: [#[
            operation: "reverse"
        ] #[
            operation: "reverse"
        ] #[
            operation: "pop"
            expected: 3
        ] #[
            operation: "pop"
            expected: 2
        ] #[
            operation: "pop"
            expected: 1
        ]]
    ]
    expected: #[]
    function: "list"
    uuid: "9b53af96-7494-4cfa-9b77-b7366fed5c4c"
]]

foreach c-case canonical-cases [
	operations-code: copy []

	foreach operation c-case/input/operations [
		expect-code: operation-code operation
		either find operation 'expected [
			expected: operation/expected
			insert tail operations-code either all [
				map? expected
				string? expected/error
			] [
				reduce ['expect-error/message quote 'user expect-code expected/error]
			] [
				reduce ['expect expected expect-code]
			]
		] [
			insert tail operations-code expect-code
		]
	]
	insert tail operations-code [assert [true]]

	case-code: load rejoin [
		"set 'list new-list " mold any [c-case/input/initialValues []] "^/"
		mold/only operations-code
	]

	test c-case/description case-code
]

test-results/print
