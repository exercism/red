Red [
	description: {Tests for Circular Buffer Exercism exercise}
	author: "loziniak"
]

#include %testlib.red

test-init/limit %circular-buffer.red 1
; test-init/limit %.meta/example.red 1						; test example solution

canonical-cases: [#(
    description: "reading empty buffer should fail"
    input: #(
        capacity: 1
        operations: [read]
    )
    expected: [false]
    function: "run"
    uuid: "28268ed4-4ff3-45f3-820e-895b44d53dfa"
) #(
    description: "can read an item just written"
    input: #(
        capacity: 1
        operations: [write 1 read]
    )
    expected: [true 1]
    function: "run"
    uuid: "2e6db04a-58a1-425d-ade8-ac30b5f318f3"
) #(
    description: "each item may only be read once"
    input: #(
        capacity: 1
        operations: [write 1 read read]
    )
    expected: [true 1 false]
    function: "run"
    uuid: "90741fe8-a448-45ce-be2b-de009a24c144"
) #(
    description: "items are read in the order they are written"
    input: #(
        capacity: 2
        operations: [write 1 write 2 read read]
    )
    expected: [true true 1 2]
    function: "run"
    uuid: "be0e62d5-da9c-47a8-b037-5db21827baa7"
) #(
    description: "full buffer can't be written to"
    input: #(
        capacity: 1
        operations: [write 1 write 2]
    )
    expected: [true false]
    function: "run"
    uuid: "2af22046-3e44-4235-bfe6-05ba60439d38"
) #(
    description: "a read frees up capacity for another write"
    input: #(
        capacity: 1
        operations: [write 1 read write 2 read]
    )
    expected: [true 1 true 2]
    function: "run"
    uuid: "547d192c-bbf0-4369-b8fa-fc37e71f2393"
) #(
    description: {read position is maintained even across multiple writes}
    input: #(
        capacity: 3
        operations: [write 1 write 2 read write 3 read read]
    )
    expected: [true true 1 true 2 3]
    function: "run"
    uuid: "04a56659-3a81-4113-816b-6ecb659b4471"
) #(
    description: "items cleared out of buffer can't be read"
    input: #(
        capacity: 1
        operations: [write 1 clear read]
    )
    expected: [true false]
    function: "run"
    uuid: "60c3a19a-81a7-43d7-bb0a-f07242b1111f"
) #(
    description: "clear frees up capacity for another write"
    input: #(
        capacity: 1
        operations: [write 1 clear write 2 read]
    )
    expected: [true true 2]
    function: "run"
    uuid: "45f3ae89-3470-49f3-b50e-362e4b330a59"
) #(
    description: "clear does nothing on empty buffer"
    input: #(
        capacity: 1
        operations: [clear write 1 read]
    )
    expected: [true 1]
    function: "run"
    uuid: "e1ac5170-a026-4725-bfbe-0cf332eddecd"
) #(
    description: "overwrite acts like write on non-full buffer"
    input: #(
        capacity: 2
        operations: [write 1 overwrite 2 read read]
    )
    expected: [true 1 2]
    function: "run"
    uuid: "9c2d4f26-3ec7-453f-a895-7e7ff8ae7b5b"
) #(
    description: "overwrite replaces the oldest item on full buffer"
    input: #(
        capacity: 2
        operations: [write 1 write 2 overwrite 3 read read]
    )
    expected: [true true 2 3]
    function: "run"
    uuid: "880f916b-5039-475c-bd5c-83463c36a147"
) #(
    description: {overwrite replaces the oldest item remaining in buffer following a read}
    input: #(
        capacity: 3
        operations: [write 1 write 2 write 3 read write 4 overwrite 5 read read read]
    )
    expected: [true true true 1 true 3 4 5]
    function: "run"
    uuid: "bfecab5b-aca1-4fab-a2b0-cd4af2b053c3"
) #(
    description: "initial clear does not affect wrapping around"
    input: #(
        capacity: 2
        operations: [clear write 1 write 2 overwrite 3 overwrite 4 read read read]
    )
    expected: [true true 3 4 false]
    function: "run"
    uuid: "9cebe63a-c405-437b-8b62-e3fdc1ecec5a"
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
