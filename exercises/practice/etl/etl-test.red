Red [
	description: {Tests for "ETL" Exercism exercise}
	author: "loziniak"
]

#include %testlib.red

test-init/limit %etl.red 1
; test-init/limit %.meta/example.red 1						; test example solution

canonical-cases: [#[
    description: "single letter"
    input: #[
        legacy: #[
            "1" ["A"]
        ]
    ]
    expected: #[
        a: 1
    ]
    function: "transform"
    uuid: "78a7a9f9-4490-4a47-8ee9-5a38bb47d28f"
] #[
    description: "single score with multiple letters"
    input: #[
        legacy: #[
            "1" ["A" "E" "I" "O" "U"]
        ]
    ]
    expected: #[
        a: 1
        e: 1
        i: 1
        o: 1
        u: 1
    ]
    function: "transform"
    uuid: "60dbd000-451d-44c7-bdbb-97c73ac1f497"
] #[
    description: "multiple scores with multiple letters"
    input: #[
        legacy: #[
            "1" ["A" "E"]
            "2" ["D" "G"]
        ]
    ]
    expected: #[
        a: 1
        d: 2
        e: 1
        g: 2
    ]
    function: "transform"
    uuid: "f5c5de0c-301f-4fdd-a0e5-df97d4214f54"
] #[
    description: "multiple scores with differing numbers of letters"
    input: #[
        legacy: #[
            "1" ["A" "E" "I" "O" "U" "L" "N" "R" "S" "T"]
            "2" ["D" "G"]
            "3" ["B" "C" "M" "P"]
            "4" ["F" "H" "V" "W" "Y"]
            "5" ["K"]
            "8" ["J" "X"]
            "10" ["Q" "Z"]
        ]
    ]
    expected: #[
        a: 1
        b: 3
        c: 3
        d: 2
        e: 1
        f: 4
        g: 2
        h: 4
        i: 1
        j: 8
        k: 5
        l: 1
        m: 3
        n: 1
        o: 1
        p: 3
        q: 10
        r: 1
        s: 1
        t: 1
        u: 1
        v: 4
        w: 4
        x: 8
        y: 4
        z: 10
    ]
    function: "transform"
    uuid: "5db8ea89-ecb4-4dcd-902f-2b418cc87b9d"
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
