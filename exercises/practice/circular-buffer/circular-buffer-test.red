Red [
	description: {Tests for Circular Buffer Exercism exercise}
	author: "loziniak"
]

exercise-slug: "circular-buffer"
ignore-after: 1


canonical-cases: [#(
    description: "reading empty buffer should fail"
    input: #(
        capacity: 1
        operations: [#(
            operation: "read"
            should_succeed: false
        )]
    )
    expected: #()
    function: "run"
    uuid: "28268ed4-4ff3-45f3-820e-895b44d53dfa"
) #(
    description: "can read an item just written"
    input: #(
        capacity: 1
        operations: [#(
            operation: "write"
            item: 1
            should_succeed: true
        ) #(
            operation: "read"
            should_succeed: true
            expected: 1
        )]
    )
    expected: #()
    function: "run"
    uuid: "2e6db04a-58a1-425d-ade8-ac30b5f318f3"
) #(
    description: "each item may only be read once"
    input: #(
        capacity: 1
        operations: [#(
            operation: "write"
            item: 1
            should_succeed: true
        ) #(
            operation: "read"
            should_succeed: true
            expected: 1
        ) #(
            operation: "read"
            should_succeed: false
        )]
    )
    expected: #()
    function: "run"
    uuid: "90741fe8-a448-45ce-be2b-de009a24c144"
) #(
    description: "items are read in the order they are written"
    input: #(
        capacity: 2
        operations: [#(
            operation: "write"
            item: 1
            should_succeed: true
        ) #(
            operation: "write"
            item: 2
            should_succeed: true
        ) #(
            operation: "read"
            should_succeed: true
            expected: 1
        ) #(
            operation: "read"
            should_succeed: true
            expected: 2
        )]
    )
    expected: #()
    function: "run"
    uuid: "be0e62d5-da9c-47a8-b037-5db21827baa7"
) #(
    description: "full buffer can't be written to"
    input: #(
        capacity: 1
        operations: [#(
            operation: "write"
            item: 1
            should_succeed: true
        ) #(
            operation: "write"
            item: 2
            should_succeed: false
        )]
    )
    expected: #()
    function: "run"
    uuid: "2af22046-3e44-4235-bfe6-05ba60439d38"
) #(
    description: "a read frees up capacity for another write"
    input: #(
        capacity: 1
        operations: [#(
            operation: "write"
            item: 1
            should_succeed: true
        ) #(
            operation: "read"
            should_succeed: true
            expected: 1
        ) #(
            operation: "write"
            item: 2
            should_succeed: true
        ) #(
            operation: "read"
            should_succeed: true
            expected: 2
        )]
    )
    expected: #()
    function: "run"
    uuid: "547d192c-bbf0-4369-b8fa-fc37e71f2393"
) #(
    description: {read position is maintained even across multiple writes}
    input: #(
        capacity: 3
        operations: [#(
            operation: "write"
            item: 1
            should_succeed: true
        ) #(
            operation: "write"
            item: 2
            should_succeed: true
        ) #(
            operation: "read"
            should_succeed: true
            expected: 1
        ) #(
            operation: "write"
            item: 3
            should_succeed: true
        ) #(
            operation: "read"
            should_succeed: true
            expected: 2
        ) #(
            operation: "read"
            should_succeed: true
            expected: 3
        )]
    )
    expected: #()
    function: "run"
    uuid: "04a56659-3a81-4113-816b-6ecb659b4471"
) #(
    description: "items cleared out of buffer can't be read"
    input: #(
        capacity: 1
        operations: [#(
            operation: "write"
            item: 1
            should_succeed: true
        ) #(
            operation: "clear"
        ) #(
            operation: "read"
            should_succeed: false
        )]
    )
    expected: #()
    function: "run"
    uuid: "60c3a19a-81a7-43d7-bb0a-f07242b1111f"
) #(
    description: "clear frees up capacity for another write"
    input: #(
        capacity: 1
        operations: [#(
            operation: "write"
            item: 1
            should_succeed: true
        ) #(
            operation: "clear"
        ) #(
            operation: "write"
            item: 2
            should_succeed: true
        ) #(
            operation: "read"
            should_succeed: true
            expected: 2
        )]
    )
    expected: #()
    function: "run"
    uuid: "45f3ae89-3470-49f3-b50e-362e4b330a59"
) #(
    description: "clear does nothing on empty buffer"
    input: #(
        capacity: 1
        operations: [#(
            operation: "clear"
        ) #(
            operation: "write"
            item: 1
            should_succeed: true
        ) #(
            operation: "read"
            should_succeed: true
            expected: 1
        )]
    )
    expected: #()
    function: "run"
    uuid: "e1ac5170-a026-4725-bfbe-0cf332eddecd"
) #(
    description: "overwrite acts like write on non-full buffer"
    input: #(
        capacity: 2
        operations: [#(
            operation: "write"
            item: 1
            should_succeed: true
        ) #(
            operation: "overwrite"
            item: 2
        ) #(
            operation: "read"
            should_succeed: true
            expected: 1
        ) #(
            operation: "read"
            should_succeed: true
            expected: 2
        )]
    )
    expected: #()
    function: "run"
    uuid: "9c2d4f26-3ec7-453f-a895-7e7ff8ae7b5b"
) #(
    description: "overwrite replaces the oldest item on full buffer"
    input: #(
        capacity: 2
        operations: [#(
            operation: "write"
            item: 1
            should_succeed: true
        ) #(
            operation: "write"
            item: 2
            should_succeed: true
        ) #(
            operation: "overwrite"
            item: 3
        ) #(
            operation: "read"
            should_succeed: true
            expected: 2
        ) #(
            operation: "read"
            should_succeed: true
            expected: 3
        )]
    )
    expected: #()
    function: "run"
    uuid: "880f916b-5039-475c-bd5c-83463c36a147"
) #(
    description: {overwrite replaces the oldest item remaining in buffer following a read}
    input: #(
        capacity: 3
        operations: [#(
            operation: "write"
            item: 1
            should_succeed: true
        ) #(
            operation: "write"
            item: 2
            should_succeed: true
        ) #(
            operation: "write"
            item: 3
            should_succeed: true
        ) #(
            operation: "read"
            should_succeed: true
            expected: 1
        ) #(
            operation: "write"
            item: 4
            should_succeed: true
        ) #(
            operation: "overwrite"
            item: 5
        ) #(
            operation: "read"
            should_succeed: true
            expected: 3
        ) #(
            operation: "read"
            should_succeed: true
            expected: 4
        ) #(
            operation: "read"
            should_succeed: true
            expected: 5
        )]
    )
    expected: #()
    function: "run"
    uuid: "bfecab5b-aca1-4fab-a2b0-cd4af2b053c3"
) #(
    description: "initial clear does not affect wrapping around"
    input: #(
        capacity: 2
        operations: [#(
            operation: "clear"
        ) #(
            operation: "write"
            item: 1
            should_succeed: true
        ) #(
            operation: "write"
            item: 2
            should_succeed: true
        ) #(
            operation: "overwrite"
            item: 3
        ) #(
            operation: "overwrite"
            item: 4
        ) #(
            operation: "read"
            should_succeed: true
            expected: 3
        ) #(
            operation: "read"
            should_succeed: true
            expected: 4
        ) #(
            operation: "read"
            should_succeed: false
        )]
    )
    expected: #()
    function: "run"
    uuid: "9cebe63a-c405-437b-8b62-e3fdc1ecec5a"
)]



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

	result: try [
		catch [
			do result-execution
		]
	]

	if error? result [
		either result/type = 'user [
			result: make map! reduce ['error result/arg1]
		] [
			print result
		]
	]

	print [
		pad/with test-case/description 30 #"."
		either result = test-case/expected [
			"✓"
		] [
			rejoin [{FAILED. Expected: "} test-case/expected {", but got "} result {"}]
		]
	]
]

print [
	(length? canonical-cases) - ignore-after
	"cases ignored."
]
