Red [
	description: {Tests for "Allergies" Exercism exercise}
	author: "loziniak"
]

#include %testlib.red

test-init/limit %allergies.red 1
; test-init/limit %.meta/example.red 1						; test example solution

canonical-cases: [#[
    description: "not allergic to anything"
    input: #[
        item: "eggs"
        score: 0
    ]
    expected: false
    function: "allergic-to"
    uuid: "17fc7296-2440-4ac4-ad7b-d07c321bc5a0"
] #[
    description: "allergic only to eggs"
    input: #[
        item: "eggs"
        score: 1
    ]
    expected: true
    function: "allergic-to"
    uuid: "07ced27b-1da5-4c2e-8ae2-cb2791437546"
] #[
    description: "allergic to eggs and something else"
    input: #[
        item: "eggs"
        score: 3
    ]
    expected: true
    function: "allergic-to"
    uuid: "5035b954-b6fa-4b9b-a487-dae69d8c5f96"
] #[
    description: "allergic to something, but not eggs"
    input: #[
        item: "eggs"
        score: 2
    ]
    expected: false
    function: "allergic-to"
    uuid: "64a6a83a-5723-4b5b-a896-663307403310"
] #[
    description: "allergic to everything"
    input: #[
        item: "eggs"
        score: 255
    ]
    expected: true
    function: "allergic-to"
    uuid: "90c8f484-456b-41c4-82ba-2d08d93231c6"
] #[
    description: "not allergic to anything"
    input: #[
        item: "peanuts"
        score: 0
    ]
    expected: false
    function: "allergic-to"
    uuid: "d266a59a-fccc-413b-ac53-d57cb1f0db9d"
] #[
    description: "allergic only to peanuts"
    input: #[
        item: "peanuts"
        score: 2
    ]
    expected: true
    function: "allergic-to"
    uuid: "ea210a98-860d-46b2-a5bf-50d8995b3f2a"
] #[
    description: "allergic to peanuts and something else"
    input: #[
        item: "peanuts"
        score: 7
    ]
    expected: true
    function: "allergic-to"
    uuid: "eac69ae9-8d14-4291-ac4b-7fd2c73d3a5b"
] #[
    description: "allergic to something, but not peanuts"
    input: #[
        item: "peanuts"
        score: 5
    ]
    expected: false
    function: "allergic-to"
    uuid: "9152058c-ce39-4b16-9b1d-283ec6d25085"
] #[
    description: "allergic to everything"
    input: #[
        item: "peanuts"
        score: 255
    ]
    expected: true
    function: "allergic-to"
    uuid: "d2d71fd8-63d5-40f9-a627-fbdaf88caeab"
] #[
    description: "not allergic to anything"
    input: #[
        item: "shellfish"
        score: 0
    ]
    expected: false
    function: "allergic-to"
    uuid: "b948b0a1-cbf7-4b28-a244-73ff56687c80"
] #[
    description: "allergic only to shellfish"
    input: #[
        item: "shellfish"
        score: 4
    ]
    expected: true
    function: "allergic-to"
    uuid: "9ce9a6f3-53e9-4923-85e0-73019047c567"
] #[
    description: "allergic to shellfish and something else"
    input: #[
        item: "shellfish"
        score: 14
    ]
    expected: true
    function: "allergic-to"
    uuid: "b272fca5-57ba-4b00-bd0c-43a737ab2131"
] #[
    description: "allergic to something, but not shellfish"
    input: #[
        item: "shellfish"
        score: 10
    ]
    expected: false
    function: "allergic-to"
    uuid: "21ef8e17-c227-494e-8e78-470a1c59c3d8"
] #[
    description: "allergic to everything"
    input: #[
        item: "shellfish"
        score: 255
    ]
    expected: true
    function: "allergic-to"
    uuid: "cc789c19-2b5e-4c67-b146-625dc8cfa34e"
] #[
    description: "not allergic to anything"
    input: #[
        item: "strawberries"
        score: 0
    ]
    expected: false
    function: "allergic-to"
    uuid: "651bde0a-2a74-46c4-ab55-02a0906ca2f5"
] #[
    description: "allergic only to strawberries"
    input: #[
        item: "strawberries"
        score: 8
    ]
    expected: true
    function: "allergic-to"
    uuid: "b649a750-9703-4f5f-b7f7-91da2c160ece"
] #[
    description: "allergic to strawberries and something else"
    input: #[
        item: "strawberries"
        score: 28
    ]
    expected: true
    function: "allergic-to"
    uuid: "50f5f8f3-3bac-47e6-8dba-2d94470a4bc6"
] #[
    description: "allergic to something, but not strawberries"
    input: #[
        item: "strawberries"
        score: 20
    ]
    expected: false
    function: "allergic-to"
    uuid: "23dd6952-88c9-48d7-a7d5-5d0343deb18d"
] #[
    description: "allergic to everything"
    input: #[
        item: "strawberries"
        score: 255
    ]
    expected: true
    function: "allergic-to"
    uuid: "74afaae2-13b6-43a2-837a-286cd42e7d7e"
] #[
    description: "not allergic to anything"
    input: #[
        item: "tomatoes"
        score: 0
    ]
    expected: false
    function: "allergic-to"
    uuid: "c49a91ef-6252-415e-907e-a9d26ef61723"
] #[
    description: "allergic only to tomatoes"
    input: #[
        item: "tomatoes"
        score: 16
    ]
    expected: true
    function: "allergic-to"
    uuid: "b69c5131-b7d0-41ad-a32c-e1b2cc632df8"
] #[
    description: "allergic to tomatoes and something else"
    input: #[
        item: "tomatoes"
        score: 56
    ]
    expected: true
    function: "allergic-to"
    uuid: "1ca50eb1-f042-4ccf-9050-341521b929ec"
] #[
    description: "allergic to something, but not tomatoes"
    input: #[
        item: "tomatoes"
        score: 40
    ]
    expected: false
    function: "allergic-to"
    uuid: "e9846baa-456b-4eff-8025-034b9f77bd8e"
] #[
    description: "allergic to everything"
    input: #[
        item: "tomatoes"
        score: 255
    ]
    expected: true
    function: "allergic-to"
    uuid: "b2414f01-f3ad-4965-8391-e65f54dad35f"
] #[
    description: "not allergic to anything"
    input: #[
        item: "chocolate"
        score: 0
    ]
    expected: false
    function: "allergic-to"
    uuid: "978467ab-bda4-49f7-b004-1d011ead947c"
] #[
    description: "allergic only to chocolate"
    input: #[
        item: "chocolate"
        score: 32
    ]
    expected: true
    function: "allergic-to"
    uuid: "59cf4e49-06ea-4139-a2c1-d7aad28f8cbc"
] #[
    description: "allergic to chocolate and something else"
    input: #[
        item: "chocolate"
        score: 112
    ]
    expected: true
    function: "allergic-to"
    uuid: "b0a7c07b-2db7-4f73-a180-565e07040ef1"
] #[
    description: "allergic to something, but not chocolate"
    input: #[
        item: "chocolate"
        score: 80
    ]
    expected: false
    function: "allergic-to"
    uuid: "f5506893-f1ae-482a-b516-7532ba5ca9d2"
] #[
    description: "allergic to everything"
    input: #[
        item: "chocolate"
        score: 255
    ]
    expected: true
    function: "allergic-to"
    uuid: "02debb3d-d7e2-4376-a26b-3c974b6595c6"
] #[
    description: "not allergic to anything"
    input: #[
        item: "pollen"
        score: 0
    ]
    expected: false
    function: "allergic-to"
    uuid: "17f4a42b-c91e-41b8-8a76-4797886c2d96"
] #[
    description: "allergic only to pollen"
    input: #[
        item: "pollen"
        score: 64
    ]
    expected: true
    function: "allergic-to"
    uuid: "7696eba7-1837-4488-882a-14b7b4e3e399"
] #[
    description: "allergic to pollen and something else"
    input: #[
        item: "pollen"
        score: 224
    ]
    expected: true
    function: "allergic-to"
    uuid: "9a49aec5-fa1f-405d-889e-4dfc420db2b6"
] #[
    description: "allergic to something, but not pollen"
    input: #[
        item: "pollen"
        score: 160
    ]
    expected: false
    function: "allergic-to"
    uuid: "3cb8e79f-d108-4712-b620-aa146b1954a9"
] #[
    description: "allergic to everything"
    input: #[
        item: "pollen"
        score: 255
    ]
    expected: true
    function: "allergic-to"
    uuid: "1dc3fe57-7c68-4043-9d51-5457128744b2"
] #[
    description: "not allergic to anything"
    input: #[
        item: "cats"
        score: 0
    ]
    expected: false
    function: "allergic-to"
    uuid: "d3f523d6-3d50-419b-a222-d4dfd62ce314"
] #[
    description: "allergic only to cats"
    input: #[
        item: "cats"
        score: 128
    ]
    expected: true
    function: "allergic-to"
    uuid: "eba541c3-c886-42d3-baef-c048cb7fcd8f"
] #[
    description: "allergic to cats and something else"
    input: #[
        item: "cats"
        score: 192
    ]
    expected: true
    function: "allergic-to"
    uuid: "ba718376-26e0-40b7-bbbe-060287637ea5"
] #[
    description: "allergic to something, but not cats"
    input: #[
        item: "cats"
        score: 64
    ]
    expected: false
    function: "allergic-to"
    uuid: "3c6dbf4a-5277-436f-8b88-15a206f2d6c4"
] #[
    description: "allergic to everything"
    input: #[
        item: "cats"
        score: 255
    ]
    expected: true
    function: "allergic-to"
    uuid: "1faabb05-2b98-4995-9046-d83e4a48a7c1"
] #[
    description: "no allergies"
    input: #[
        score: 0
    ]
    expected: []
    function: "list"
    uuid: "f9c1b8e7-7dc5-4887-aa93-cebdcc29dd8f"
] #[
    description: "just eggs"
    input: #[
        score: 1
    ]
    expected: ["eggs"]
    function: "list"
    uuid: "9e1a4364-09a6-4d94-990f-541a94a4c1e8"
] #[
    description: "just peanuts"
    input: #[
        score: 2
    ]
    expected: ["peanuts"]
    function: "list"
    uuid: "8851c973-805e-4283-9e01-d0c0da0e4695"
] #[
    description: "just strawberries"
    input: #[
        score: 8
    ]
    expected: ["strawberries"]
    function: "list"
    uuid: "2c8943cb-005e-435f-ae11-3e8fb558ea98"
] #[
    description: "eggs and peanuts"
    input: #[
        score: 3
    ]
    expected: ["eggs" "peanuts"]
    function: "list"
    uuid: "6fa95d26-044c-48a9-8a7b-9ee46ec32c5c"
] #[
    description: "more than eggs but not peanuts"
    input: #[
        score: 5
    ]
    expected: ["eggs" "shellfish"]
    function: "list"
    uuid: "19890e22-f63f-4c5c-a9fb-fb6eacddfe8e"
] #[
    description: "lots of stuff"
    input: #[
        score: 248
    ]
    expected: ["strawberries" "tomatoes" "chocolate" "pollen" "cats"]
    function: "list"
    uuid: "4b68f470-067c-44e4-889f-c9fe28917d2f"
] #[
    description: "everything"
    input: #[
        score: 255
    ]
    expected: ["eggs" "peanuts" "shellfish" "strawberries" "tomatoes" "chocolate" "pollen" "cats"]
    function: "list"
    uuid: "0881b7c5-9efa-4530-91bd-68370d054bc7"
] #[
    description: "no allergen score parts"
    input: #[
        score: 509
    ]
    expected: ["eggs" "shellfish" "strawberries" "tomatoes" "chocolate" "pollen" "cats"]
    function: "list"
    uuid: "12ce86de-b347-42a0-ab7c-2e0570f0c65b"
] #[
    description: {no allergen score parts without highest valid score}
    input: #[
        score: 257
    ]
    expected: ["eggs"]
    function: "list"
    uuid: "93c2df3e-4f55-4fed-8116-7513092819cd"
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
