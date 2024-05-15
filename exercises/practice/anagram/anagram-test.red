Red [
	description: {Tests for "Anagram" Exercism exercise}
	author: "loziniak"
]

#include %testlib.red

test-init/limit %anagram.red 1
; test-init/limit %.meta/example.red 1						; test example solution

canonical-cases: [#[
    description: "no matches"
    input: #[
        subject: "diaper"
        candidates: ["hello" "world" "zombies" "pants"]
    ]
    expected: []
    function: "find-anagrams"
    uuid: "dd40c4d2-3c8b-44e5-992a-f42b393ec373"
] #[
    description: "detects two anagrams"
    input: #[
        subject: "solemn"
        candidates: ["lemons" "cherry" "melons"]
    ]
    expected: ["lemons" "melons"]
    function: "find-anagrams"
    uuid: "03eb9bbe-8906-4ea0-84fa-ffe711b52c8b"
] #[
    description: "does not detect anagram subsets"
    input: #[
        subject: "good"
        candidates: ["dog" "goody"]
    ]
    expected: []
    function: "find-anagrams"
    uuid: "a27558ee-9ba0-4552-96b1-ecf665b06556"
] #[
    description: "detects anagram"
    input: #[
        subject: "listen"
        candidates: ["enlists" "google" "inlets" "banana"]
    ]
    expected: ["inlets"]
    function: "find-anagrams"
    uuid: "64cd4584-fc15-4781-b633-3d814c4941a4"
] #[
    description: "detects three anagrams"
    input: #[
        subject: "allergy"
        candidates: ["gallery" "ballerina" "regally" "clergy" "largely" "leading"]
    ]
    expected: ["gallery" "regally" "largely"]
    function: "find-anagrams"
    uuid: "99c91beb-838f-4ccd-b123-935139917283"
] #[
    description: "detects multiple anagrams with different case"
    input: #[
        subject: "nose"
        candidates: ["Eons" "ONES"]
    ]
    expected: ["Eons" "ONES"]
    function: "find-anagrams"
    uuid: "78487770-e258-4e1f-a646-8ece10950d90"
] #[
    description: {does not detect non-anagrams with identical checksum}
    input: #[
        subject: "mass"
        candidates: ["last"]
    ]
    expected: []
    function: "find-anagrams"
    uuid: "1d0ab8aa-362f-49b7-9902-3d0c668d557b"
] #[
    description: "detects anagrams case-insensitively"
    input: #[
        subject: "Orchestra"
        candidates: ["cashregister" "Carthorse" "radishes"]
    ]
    expected: ["Carthorse"]
    function: "find-anagrams"
    uuid: "9e632c0b-c0b1-4804-8cc1-e295dea6d8a8"
] #[
    description: "detects anagrams using case-insensitive subject"
    input: #[
        subject: "Orchestra"
        candidates: ["cashregister" "carthorse" "radishes"]
    ]
    expected: ["carthorse"]
    function: "find-anagrams"
    uuid: "b248e49f-0905-48d2-9c8d-bd02d8c3e392"
] #[
    description: {detects anagrams using case-insensitive possible matches}
    input: #[
        subject: "orchestra"
        candidates: ["cashregister" "Carthorse" "radishes"]
    ]
    expected: ["Carthorse"]
    function: "find-anagrams"
    uuid: "f367325c-78ec-411c-be76-e79047f4bd54"
]#[
    description: {does not detect an anagram if the original word is repeated}
    input: #[
        subject: "go"
        candidates: ["goGoGO"]
    ]
    expected: []
    function: "find-anagrams"
    uuid: "630abb71-a94e-4715-8395-179ec1df9f91"
] #[
    description: "anagrams must use all letters exactly once"
    input: #[
        subject: "tapper"
        candidates: ["patter"]
    ]
    expected: []
    function: "find-anagrams"
    uuid: "9878a1c9-d6ea-4235-ae51-3ea2befd6842"
] #[
    description: "words are not anagrams of themselves"
    input: #[
        subject: "BANANA"
        candidates: ["BANANA"]
    ]
    expected: []
    function: "find-anagrams"
    uuid: "68934ed0-010b-4ef9-857a-20c9012d1ebf"
] #[
    description: {words are not anagrams of themselves even if letter case is partially different}
    input: #[
        subject: "BANANA"
        candidates: ["Banana"]
    ]
    expected: []
    function: "find-anagrams"
    uuid: "589384f3-4c8a-4e7d-9edc-51c3e5f0c90e"
] #[
    description: {words are not anagrams of themselves even if letter case is completely different}
    input: #[
        subject: "BANANA"
        candidates: ["banana"]
    ]
    expected: []
    function: "find-anagrams"
    uuid: "ba53e423-7e02-41ee-9ae2-71f91e6d18e6"
] #[
    description: "words other than themselves can be anagrams"
    input: #[
        subject: "LISTEN"
        candidates: ["LISTEN" "Silent"]
    ]
    expected: ["Silent"]
    function: "find-anagrams"
    uuid: "33d3f67e-fbb9-49d3-a90e-0beb00861da7"
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
