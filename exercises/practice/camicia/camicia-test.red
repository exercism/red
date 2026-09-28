Red [
	description: {Tests for "Camicia" Exercism exercise}
	author: "loziniak"
]

#include %testlib.red

test-init/limit %camicia.red 1
; test-init/limit %.meta/example.red 1						; test example solution

canonical-cases: [#[
    description: "two cards, one trick"
    input: #[
        playerA: ["2"]
        playerB: ["3"]
    ]
    expected: #[
        status: "finished"
        cards: 2
        tricks: 1
    ]
    function: "simulate-game"
    uuid: "0b7f737c-3ecd-4a55-b34d-e65c62a85c28"
] #[
    description: "three cards, one trick"
    input: #[
        playerA: ["2" "4"]
        playerB: ["3"]
    ]
    expected: #[
        status: "finished"
        cards: 3
        tricks: 1
    ]
    function: "simulate-game"
    uuid: "27c19d75-53a5-48e5-b33b-232c3884d4f3"
] #[
    description: "four cards, one trick"
    input: #[
        playerA: ["2" "4"]
        playerB: ["3" "5" "6"]
    ]
    expected: #[
        status: "finished"
        cards: 4
        tricks: 1
    ]
    function: "simulate-game"
    uuid: "9b02dd49-efaf-4b71-adca-a05c18a7c5b0"
] #[
    description: "the ace reigns supreme"
    input: #[
        playerA: ["2" "A"]
        playerB: ["3" "4" "5" "6" "7"]
    ]
    expected: #[
        status: "finished"
        cards: 7
        tricks: 1
    ]
    function: "simulate-game"
    uuid: "fa3f4479-466a-4734-a001-ab79bfe27260"
] #[
    description: "the king beats ace"
    input: #[
        playerA: ["2" "A"]
        playerB: ["3" "4" "5" "6" "K"]
    ]
    expected: #[
        status: "finished"
        cards: 7
        tricks: 1
    ]
    function: "simulate-game"
    uuid: "07629689-f589-4f54-a6d1-8ce22776ce72"
] #[
    description: "the queen seduces the king"
    input: #[
        playerA: ["2" "A" "7" "8" "Q"]
        playerB: ["3" "4" "5" "6" "K"]
    ]
    expected: #[
        status: "finished"
        cards: 10
        tricks: 1
    ]
    function: "simulate-game"
    uuid: "54d4a1c5-76fb-4d1e-8358-0e0296ac0601"
] #[
    description: "the jack betrays the queen"
    input: #[
        playerA: ["2" "A" "7" "8" "Q"]
        playerB: ["3" "4" "5" "6" "K" "9" "J"]
    ]
    expected: #[
        status: "finished"
        cards: 12
        tricks: 1
    ]
    function: "simulate-game"
    uuid: "c875500c-ff3d-47a4-bd1e-b60b90da80aa"
] #[
    description: "the 10 just wants to put on a show"
    input: #[
        playerA: ["2" "A" "7" "8" "Q" "10"]
        playerB: ["3" "4" "5" "6" "K" "9" "J"]
    ]
    expected: #[
        status: "finished"
        cards: 13
        tricks: 1
    ]
    function: "simulate-game"
    uuid: "436875da-96ca-4149-be22-0b78173b8125"
] #[
    description: "simple loop with decks of 3 cards"
    input: #[
        playerA: ["J" "2" "3"]
        playerB: ["4" "J" "5"]
    ]
    expected: #[
        status: "loop"
        cards: 8
        tricks: 3
    ]
    function: "simulate-game"
    uuid: "5be39bb6-1b34-4ce6-a1cd-0fcc142bb272"
] #[
    description: "the story is starting to get a bit complicated"
    input: #[
        playerA: ["2" "6" "6" "J" "4" "K" "Q" "10" "K" "J" "Q" "2" "3" "K" "5" "6" "Q" "Q" "A" "A" "6" "9" "K" "A" "8" "K" "2" "A" "9" "A" "Q" "4" "K" "K" "K" "3" "5" "K" "8" "Q" "3" "Q" "7" "J" "K" "J" "9" "J" "3" "3" "K" "K" "Q" "A" "K" "7" "10" "A" "Q" "7" "10" "J" "4" "5" "J" "9" "10" "Q" "J" "J" "K" "6" "10" "J" "6" "Q" "J" "5" "J" "Q" "Q" "8" "3" "8" "A" "2" "6" "9" "K" "7" "J" "K" "K" "8" "K" "Q" "6" "10" "J" "10" "J" "Q" "J" "10" "3" "8" "K" "A" "6" "9" "K" "2" "A" "A" "10" "J" "6" "A" "4" "J" "A" "J" "J" "6" "2" "J" "3" "K" "2" "5" "9" "J" "9" "6" "K" "A" "5" "Q" "J" "2" "Q" "K" "A" "3" "K" "J" "K" "2" "5" "6" "Q" "J" "Q" "Q" "J" "2" "J" "9" "Q" "7" "7" "A" "Q" "7" "Q" "J" "K" "J" "A" "7" "7" "8" "Q" "10" "J" "10" "J" "J" "9" "2" "A" "2"]
        playerB: ["7" "2" "10" "K" "8" "2" "J" "9" "A" "5" "6" "J" "Q" "6" "K" "6" "5" "A" "4" "Q" "7" "J" "7" "10" "2" "Q" "8" "2" "2" "K" "J" "A" "5" "5" "A" "4" "Q" "6" "Q" "K" "10" "8" "Q" "2" "10" "J" "A" "Q" "8" "Q" "Q" "J" "J" "A" "A" "9" "10" "J" "K" "4" "Q" "10" "10" "J" "K" "10" "2" "J" "7" "A" "K" "K" "J" "A" "J" "10" "8" "K" "A" "7" "Q" "Q" "J" "3" "Q" "4" "A" "3" "A" "Q" "Q" "Q" "5" "4" "K" "J" "10" "A" "Q" "J" "6" "J" "A" "10" "A" "5" "8" "3" "K" "5" "9" "Q" "8" "7" "7" "J" "7" "Q" "Q" "Q" "A" "7" "8" "9" "A" "Q" "A" "K" "8" "A" "A" "J" "8" "4" "8" "K" "J" "A" "10" "Q" "8" "J" "8" "6" "10" "Q" "J" "J" "A" "A" "J" "5" "Q" "6" "J" "K" "Q" "8" "K" "4" "Q" "Q" "6" "J" "K" "4" "7" "J" "J" "9" "9" "A" "Q" "Q" "K" "A" "6" "5" "K"]
    ]
    expected: #[
        status: "finished"
        cards: 361
        tricks: 1
    ]
    function: "simulate-game"
    uuid: "2795dc21-0a2a-4c38-87c2-5a42e1ff15eb"
] #[
    description: "two tricks"
    input: #[
        playerA: ["J"]
        playerB: ["3" "J"]
    ]
    expected: #[
        status: "finished"
        cards: 5
        tricks: 2
    ]
    function: "simulate-game"
    uuid: "6999dfac-3fdc-41e2-b64b-38f4be228712"
] #[
    description: "more tricks"
    input: #[
        playerA: ["J" "2" "4"]
        playerB: ["3" "J" "A"]
    ]
    expected: #[
        status: "finished"
        cards: 12
        tricks: 4
    ]
    function: "simulate-game"
    uuid: "83dcd4f3-e089-4d54-855a-73f5346543a3"
] #[
    description: "simple loop with decks of 4 cards"
    input: #[
        playerA: ["2" "3" "J" "6"]
        playerB: ["K" "5" "J" "7"]
    ]
    expected: #[
        status: "loop"
        cards: 16
        tricks: 4
    ]
    function: "simulate-game"
    uuid: "3107985a-f43e-486a-9ce8-db51547a9941"
] #[
    description: "easy card combination"
    input: #[
        playerA: ["4" "8" "7" "5" "4" "10" "3" "9" "7" "3" "10" "10" "6" "8" "2" "8" "5" "4" "5" "9" "6" "5" "2" "8" "10" "9"]
        playerB: ["6" "9" "4" "7" "2" "2" "3" "6" "7" "3" "A" "A" "A" "A" "K" "K" "K" "K" "Q" "Q" "Q" "Q" "J" "J" "J" "J"]
    ]
    expected: #[
        status: "finished"
        cards: 40
        tricks: 4
    ]
    function: "simulate-game"
    uuid: "dca32c31-11ed-49f6-b078-79ab912c1f7b"
] #[
    description: "easy card combination, inverted decks"
    input: #[
        playerA: ["3" "3" "5" "7" "3" "2" "10" "7" "6" "7" "A" "A" "A" "A" "K" "K" "K" "K" "Q" "Q" "Q" "Q" "J" "J" "J" "J"]
        playerB: ["5" "10" "8" "2" "6" "7" "2" "4" "9" "2" "6" "10" "10" "5" "4" "8" "4" "8" "6" "9" "8" "5" "9" "3" "4" "9"]
    ]
    expected: #[
        status: "finished"
        cards: 40
        tricks: 4
    ]
    function: "simulate-game"
    uuid: "1f8488d0-48d3-45ae-b819-59cedad0a5f4"
] #[
    description: "mirrored decks"
    input: #[
        playerA: ["2" "A" "3" "A" "3" "K" "4" "K" "2" "Q" "2" "Q" "10" "J" "5" "J" "6" "10" "2" "9" "10" "7" "3" "9" "6" "9"]
        playerB: ["6" "A" "4" "A" "7" "K" "4" "K" "7" "Q" "7" "Q" "5" "J" "8" "J" "4" "5" "8" "9" "10" "6" "8" "3" "8" "5"]
    ]
    expected: #[
        status: "finished"
        cards: 59
        tricks: 4
    ]
    function: "simulate-game"
    uuid: "98878d35-623a-4d05-b81a-7bdc569eb88d"
] #[
    description: "opposite decks"
    input: #[
        playerA: ["4" "A" "9" "A" "4" "K" "9" "K" "6" "Q" "8" "Q" "8" "J" "10" "J" "9" "8" "4" "6" "3" "6" "5" "2" "4" "3"]
        playerB: ["10" "7" "3" "2" "9" "2" "7" "8" "7" "5" "J" "7" "J" "10" "Q" "10" "Q" "3" "K" "5" "K" "6" "A" "2" "A" "5"]
    ]
    expected: #[
        status: "finished"
        cards: 151
        tricks: 21
    ]
    function: "simulate-game"
    uuid: "3e0ba597-ca10-484b-87a3-31a7df7d6da3"
] #[
    description: "random decks #1"
    input: #[
        playerA: ["K" "10" "9" "8" "J" "8" "6" "9" "7" "A" "K" "5" "4" "4" "J" "5" "J" "4" "3" "5" "8" "6" "7" "7" "4" "9"]
        playerB: ["6" "3" "K" "A" "Q" "10" "A" "2" "Q" "8" "2" "10" "10" "2" "Q" "3" "K" "9" "7" "A" "3" "Q" "5" "J" "2" "6"]
    ]
    expected: #[
        status: "finished"
        cards: 542
        tricks: 76
    ]
    function: "simulate-game"
    uuid: "92334ddb-aaa7-47fa-ab36-e928a8a6a67c"
] #[
    description: "random decks #2"
    input: #[
        playerA: ["8" "A" "4" "8" "5" "Q" "J" "2" "6" "2" "9" "7" "K" "A" "8" "10" "K" "8" "10" "9" "K" "6" "7" "3" "K" "9"]
        playerB: ["10" "5" "2" "6" "Q" "J" "A" "9" "5" "5" "3" "7" "3" "J" "A" "2" "Q" "3" "J" "Q" "4" "10" "4" "7" "4" "6"]
    ]
    expected: #[
        status: "finished"
        cards: 327
        tricks: 42
    ]
    function: "simulate-game"
    uuid: "30477523-9651-4860-84a3-e1ac461bb7fa"
] #[
    description: "Kleber 1999"
    input: #[
        playerA: ["4" "8" "9" "J" "Q" "8" "5" "5" "K" "2" "A" "9" "8" "5" "10" "A" "4" "J" "3" "K" "6" "9" "2" "Q" "K" "7"]
        playerB: ["10" "J" "3" "2" "4" "10" "4" "7" "5" "3" "6" "6" "7" "A" "J" "Q" "A" "7" "2" "10" "3" "K" "9" "6" "8" "Q"]
    ]
    expected: #[
        status: "finished"
        cards: 5790
        tricks: 805
    ]
    function: "simulate-game"
    uuid: "20967de8-9e94-4e0e-9010-14bc1c157432"
] #[
    description: "Collins 2006"
    input: #[
        playerA: ["A" "8" "Q" "K" "9" "10" "3" "7" "4" "2" "Q" "3" "2" "10" "9" "K" "A" "8" "7" "7" "4" "5" "J" "9" "2" "10"]
        playerB: ["4" "J" "A" "K" "8" "5" "6" "6" "A" "6" "5" "Q" "4" "6" "10" "8" "J" "2" "5" "7" "Q" "J" "3" "3" "K" "9"]
    ]
    expected: #[
        status: "finished"
        cards: 6913
        tricks: 960
    ]
    function: "simulate-game"
    uuid: "9f2fdfe8-27f3-4323-816d-6bce98a9c6f7"
] #[
    description: "Mann and Wu 2007"
    input: #[
        playerA: ["K" "2" "K" "K" "3" "3" "6" "10" "K" "6" "A" "2" "5" "5" "7" "9" "J" "A" "A" "3" "4" "Q" "4" "8" "J" "6"]
        playerB: ["4" "5" "2" "Q" "7" "9" "9" "Q" "7" "J" "9" "8" "10" "3" "10" "J" "4" "10" "8" "6" "8" "7" "A" "Q" "5" "2"]
    ]
    expected: #[
        status: "finished"
        cards: 7157
        tricks: 1007
    ]
    function: "simulate-game"
    uuid: "c90b6f8d-7013-49f3-b5cb-14ea006cca1d"
] #[
    description: "Nessler 2012"
    input: #[
        playerA: ["10" "3" "6" "7" "Q" "2" "9" "8" "2" "8" "4" "A" "10" "6" "K" "2" "10" "A" "5" "A" "2" "4" "Q" "J" "K" "4"]
        playerB: ["10" "Q" "4" "6" "J" "9" "3" "J" "9" "3" "3" "Q" "K" "5" "9" "5" "K" "6" "5" "7" "8" "J" "A" "7" "8" "7"]
    ]
    expected: #[
        status: "finished"
        cards: 7207
        tricks: 1015
    ]
    function: "simulate-game"
    uuid: "a3f1fbc5-1d0b-499a-92a5-22932dfc6bc8"
] #[
    description: "Anderson 2013"
    input: #[
        playerA: ["6" "7" "A" "3" "Q" "3" "5" "J" "3" "2" "J" "7" "4" "5" "Q" "10" "5" "A" "J" "2" "K" "8" "9" "9" "K" "3"]
        playerB: ["4" "J" "6" "9" "8" "5" "10" "7" "9" "Q" "2" "7" "10" "8" "4" "10" "A" "6" "4" "A" "6" "8" "Q" "K" "K" "2"]
    ]
    expected: #[
        status: "finished"
        cards: 7225
        tricks: 1016
    ]
    function: "simulate-game"
    uuid: "9cefb1ba-e6d1-4ab7-9d8f-76d8e0976d5f"
] #[
    description: "Rucklidge 2014"
    input: #[
        playerA: ["8" "J" "2" "9" "4" "4" "5" "8" "Q" "3" "9" "3" "6" "2" "8" "A" "A" "A" "9" "4" "7" "2" "5" "Q" "Q" "3"]
        playerB: ["K" "7" "10" "6" "3" "J" "A" "7" "6" "5" "5" "8" "10" "9" "10" "4" "2" "7" "K" "Q" "10" "K" "6" "J" "J" "K"]
    ]
    expected: #[
        status: "finished"
        cards: 7959
        tricks: 1122
    ]
    function: "simulate-game"
    uuid: "d37c0318-5be6-48d0-ab72-a7aaaff86179"
] #[
    description: "Nessler 2021"
    input: #[
        playerA: ["7" "2" "3" "4" "K" "9" "6" "10" "A" "8" "9" "Q" "7" "A" "4" "8" "J" "J" "A" "4" "3" "2" "5" "6" "6" "J"]
        playerB: ["3" "10" "8" "9" "8" "K" "K" "2" "5" "5" "7" "6" "4" "3" "5" "7" "A" "9" "J" "K" "2" "Q" "10" "Q" "10" "Q"]
    ]
    expected: #[
        status: "finished"
        cards: 7972
        tricks: 1106
    ]
    function: "simulate-game"
    uuid: "4305e479-ba87-432f-8a29-cd2bd75d2f05"
] #[
    description: "Nessler 2022"
    input: #[
        playerA: ["2" "10" "10" "A" "J" "3" "8" "Q" "2" "5" "5" "5" "9" "2" "4" "3" "10" "Q" "A" "K" "Q" "J" "J" "9" "Q" "K"]
        playerB: ["10" "7" "6" "3" "6" "A" "8" "9" "4" "3" "K" "J" "6" "K" "4" "9" "7" "8" "5" "7" "8" "2" "A" "7" "4" "6"]
    ]
    expected: #[
        status: "finished"
        cards: 8344
        tricks: 1164
    ]
    function: "simulate-game"
    uuid: "252f5cc3-b86d-4251-87ce-f920b7a6a559"
] #[
    description: "Casella 2024, first infinite game found"
    input: #[
        playerA: ["2" "8" "4" "K" "5" "2" "3" "Q" "6" "K" "Q" "A" "J" "3" "5" "9" "8" "3" "A" "A" "J" "4" "4" "J" "7" "5"]
        playerB: ["7" "7" "8" "6" "10" "10" "6" "10" "7" "2" "Q" "6" "3" "2" "4" "K" "Q" "10" "J" "5" "9" "8" "9" "9" "K" "A"]
    ]
    expected: #[
        status: "loop"
        cards: 474
        tricks: 66
    ]
    function: "simulate-game"
    uuid: "b9efcfa4-842f-4542-8112-8389c714d958"
]]

foreach c-case canonical-cases [
	expect-code: compose [
		(to word! c-case/function) (values-of c-case/input)
	]
	case-code: reduce
		either all [
			map? c-case/expected
			string? c-case/expected/error
		] [
			['expect-error/message quote 'user expect-code c-case/expected/error]
		] [
			['expect c-case/expected expect-code]
		]

	test c-case/description case-code
]

test-results/print
