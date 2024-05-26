Red [
	description: {Tests for "Gigasecond" Exercism exercise}
	author: "loziniak"
]

#include %testlib.red

test-init/limit %gigasecond.red 1
; test-init/limit %.meta/example.red 1						; test example solutions

canonical-cases: [#[
    description: "date only specification of time"
    input: #[
        moment: 25-April-2011
    ]
    expected: 1-January-2043/1:46:40
    function: "add-gigasecond"
    uuid: "92fbe71c-ea52-4fac-bd77-be38023cacf7"
] #[
    description: "second test for date only specification of time"
    input: #[
        moment: 13-June-1977
    ]
    expected: 19-February-2009/1:46:40
    function: "add-gigasecond"
    uuid: "6d86dd16-6f7a-47be-9e58-bb9fb2ae1433"
] #[
    description: "third test for date only specification of time"
    input: #[
        moment: 19-July-1959
    ]
    expected: 27-March-1991/1:46:40
    function: "add-gigasecond"
    uuid: "77eb8502-2bca-4d92-89d9-7b39ace28dd5"
] #[
    description: "full time specified"
    input: #[
        moment: 24-January-2015/22:00:00
    ]
    expected: 2-October-2046/23:46:40
    function: "add-gigasecond"
    uuid: "c9d89a7d-06f8-4e28-a305-64f1b2abc693"
] #[
    description: "full time with day roll-over"
    input: #[
        moment: 24-January-2015/23:59:59
    ]
    expected: 3-October-2046/01:46:39
    function: "add-gigasecond"
    uuid: "09d4e30e-728a-4b52-9005-be44a58d9eba"
]]


foreach c-case canonical-cases [
	case-code: reduce [
		'expect c-case/expected compose [
			(to word! c-case/function) (values-of c-case/input)
		] 
	]

	test c-case/description case-code
]

test-results/print
