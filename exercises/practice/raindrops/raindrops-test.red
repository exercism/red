Red [
	description: {Tests for Raindrops Exercism exercise}
	author: "loziniak"
]

#include %testlib.red

test-init/limit %raindrops.red 1
; test-init/limit %.meta/example.red 1						; test example solution

canonical-cases: [#(
    description: "the sound for 1 is 1"
    input: #(
        number: 1
    )
    expected: "1"
    function: "convert"
    uuid: "1575d549-e502-46d4-a8e1-6b7bec6123d8"
) #(
    description: "the sound for 3 is Pling"
    input: #(
        number: 3
    )
    expected: "Pling"
    function: "convert"
    uuid: "1f51a9f9-4895-4539-b182-d7b0a5ab2913"
) #(
    description: "the sound for 5 is Plang"
    input: #(
        number: 5
    )
    expected: "Plang"
    function: "convert"
    uuid: "2d9bfae5-2b21-4bcd-9629-c8c0e388f3e0"
) #(
    description: "the sound for 7 is Plong"
    input: #(
        number: 7
    )
    expected: "Plong"
    function: "convert"
    uuid: "d7e60daa-32ef-4c23-b688-2abff46c4806"
) #(
    description: "the sound for 6 is Pling as it has a factor 3"
    input: #(
        number: 6
    )
    expected: "Pling"
    function: "convert"
    uuid: "6bb4947b-a724-430c-923f-f0dc3d62e56a"
) #(
    description: {2 to the power 3 does not make a raindrop sound as 3 is the exponent not the base}
    input: #(
        number: 8
    )
    expected: "8"
    function: "convert"
    uuid: "ce51e0e8-d9d4-446d-9949-96eac4458c2d"
) #(
    description: "the sound for 9 is Pling as it has a factor 3"
    input: #(
        number: 9
    )
    expected: "Pling"
    function: "convert"
    uuid: "0dd66175-e3e2-47fc-8750-d01739856671"
) #(
    description: "the sound for 10 is Plang as it has a factor 5"
    input: #(
        number: 10
    )
    expected: "Plang"
    function: "convert"
    uuid: "022c44d3-2182-4471-95d7-c575af225c96"
) #(
    description: "the sound for 14 is Plong as it has a factor of 7"
    input: #(
        number: 14
    )
    expected: "Plong"
    function: "convert"
    uuid: "37ab74db-fed3-40ff-b7b9-04acdfea8edf"
) #(
    description: {the sound for 15 is PlingPlang as it has factors 3 and 5}
    input: #(
        number: 15
    )
    expected: "PlingPlang"
    function: "convert"
    uuid: "31f92999-6afb-40ee-9aa4-6d15e3334d0f"
) #(
    description: {the sound for 21 is PlingPlong as it has factors 3 and 7}
    input: #(
        number: 21
    )
    expected: "PlingPlong"
    function: "convert"
    uuid: "ff9bb95d-6361-4602-be2c-653fe5239b54"
) #(
    description: "the sound for 25 is Plang as it has a factor 5"
    input: #(
        number: 25
    )
    expected: "Plang"
    function: "convert"
    uuid: "d2e75317-b72e-40ab-8a64-6734a21dece1"
) #(
    description: "the sound for 27 is Pling as it has a factor 3"
    input: #(
        number: 27
    )
    expected: "Pling"
    function: "convert"
    uuid: "a09c4c58-c662-4e32-97fe-f1501ef7125c"
) #(
    description: {the sound for 35 is PlangPlong as it has factors 5 and 7}
    input: #(
        number: 35
    )
    expected: "PlangPlong"
    function: "convert"
    uuid: "bdf061de-8564-4899-a843-14b48b722789"
) #(
    description: "the sound for 49 is Plong as it has a factor 7"
    input: #(
        number: 49
    )
    expected: "Plong"
    function: "convert"
    uuid: "c4680bee-69ba-439d-99b5-70c5fd1a7a83"
) #(
    description: "the sound for 52 is 52"
    input: #(
        number: 52
    )
    expected: "52"
    function: "convert"
    uuid: "17f2bc9a-b65a-4d23-8ccd-266e8c271444"
) #(
    description: {the sound for 105 is PlingPlangPlong as it has factors 3, 5 and 7}
    input: #(
        number: 105
    )
    expected: "PlingPlangPlong"
    function: "convert"
    uuid: "e46677ed-ff1a-419f-a740-5c713d2830e4"
) #(
    description: "the sound for 3125 is Plang as it has a factor 5"
    input: #(
        number: 3125
    )
    expected: "Plang"
    function: "convert"
    uuid: "13c6837a-0fcd-4b86-a0eb-20572f7deb0b"
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
