Red [
	description: {Tests for "Bowling" Exercism exercise}
	author: "loziniak"
]

#include %testlib.red

test-init/limit %bowling.red 1
; test-init/limit %.meta/example.red 1						; test example solution

canonical-cases: [#(
    description: "should be able to score a game with all zeros"
    input: #(
        previousRolls: [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]
    )
    expected: 0
    function: "score"
    uuid: "656ae006-25c2-438c-a549-f338e7ec7441"
) #(
    description: {should be able to score a game with no strikes or spares}
    input: #(
        previousRolls: [3 6 3 6 3 6 3 6 3 6 3 6 3 6 3 6 3 6 3 6]
    )
    expected: 90
    function: "score"
    uuid: "f85dcc56-cd6b-4875-81b3-e50921e3597b"
) #(
    description: "a spare followed by zeros is worth ten points"
    input: #(
        previousRolls: [6 4 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]
    )
    expected: 10
    function: "score"
    uuid: "d1f56305-3ac2-4fe0-8645-0b37e3073e20"
) #(
    description: {points scored in the roll after a spare are counted twice}
    input: #(
        previousRolls: [6 4 3 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]
    )
    expected: 16
    function: "score"
    uuid: "0b8c8bb7-764a-4287-801a-f9e9012f8be4"
) #(
    description: "consecutive spares each get a one roll bonus"
    input: #(
        previousRolls: [5 5 3 7 4 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]
    )
    expected: 31
    function: "score"
    uuid: "4d54d502-1565-4691-84cd-f29a09c65bea"
) #(
    description: {a spare in the last frame gets a one roll bonus that is counted once}
    input: #(
        previousRolls: [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 7 3 7]
    )
    expected: 17
    function: "score"
    uuid: "e5c9cf3d-abbe-4b74-ad48-34051b2b08c0"
) #(
    description: {a strike earns ten points in a frame with a single roll}
    input: #(
        previousRolls: [10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]
    )
    expected: 10
    function: "score"
    uuid: "75269642-2b34-4b72-95a4-9be28ab16902"
) #(
    description: {points scored in the two rolls after a strike are counted twice as a bonus}
    input: #(
        previousRolls: [10 5 3 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]
    )
    expected: 26
    function: "score"
    uuid: "037f978c-5d01-4e49-bdeb-9e20a2e6f9a6"
) #(
    description: "consecutive strikes each get the two roll bonus"
    input: #(
        previousRolls: [10 10 10 5 3 0 0 0 0 0 0 0 0 0 0 0 0]
    )
    expected: 81
    function: "score"
    uuid: "1635e82b-14ec-4cd1-bce4-4ea14bd13a49"
) #(
    description: {a strike in the last frame gets a two roll bonus that is counted once}
    input: #(
        previousRolls: [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 7 1]
    )
    expected: 18
    function: "score"
    uuid: "e483e8b6-cb4b-4959-b310-e3982030d766"
) #(
    description: {rolling a spare with the two roll bonus does not get a bonus roll}
    input: #(
        previousRolls: [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 7 3]
    )
    expected: 20
    function: "score"
    uuid: "9d5c87db-84bc-4e01-8e95-53350c8af1f8"
) #(
    description: {strikes with the two roll bonus do not get bonus rolls}
    input: #(
        previousRolls: [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 10 10]
    )
    expected: 30
    function: "score"
    uuid: "576faac1-7cff-4029-ad72-c16bcada79b5"
) #(
    description: {last two strikes followed by only last bonus with non strike points}
    input: #(
        previousRolls: [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 10 0 1]
    )
    expected: 31
    function: "score"
    uuid: "efb426ec-7e15-42e6-9b96-b4fca3ec2359"
) #(
    description: {a strike with the one roll bonus after a spare in the last frame does not get a bonus}
    input: #(
        previousRolls: [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 7 3 10]
    )
    expected: 20
    function: "score"
    uuid: "72e24404-b6c6-46af-b188-875514c0377b"
) #(
    description: "all strikes is a perfect game"
    input: #(
        previousRolls: [10 10 10 10 10 10 10 10 10 10 10 10]
    )
    expected: 300
    function: "score"
    uuid: "62ee4c72-8ee8-4250-b794-234f1fec17b1"
) #(
    description: "rolls cannot score negative points"
    input: #(
        previousRolls: []
        roll: -1
    )
    expected: #(
        error: "Negative roll is invalid"
    )
    function: "roll"
    uuid: "1245216b-19c6-422c-b34b-6e4012d7459f"
) #(
    description: "a roll cannot score more than 10 points"
    input: #(
        previousRolls: []
        roll: 11
    )
    expected: #(
        error: "Pin count exceeds pins on the lane"
    )
    function: "roll"
    uuid: "5fcbd206-782c-4faa-8f3a-be5c538ba841"
) #(
    description: {two rolls in a frame cannot score more than 10 points}
    input: #(
        previousRolls: [5]
        roll: 6
    )
    expected: #(
        error: "Pin count exceeds pins on the lane"
    )
    function: "roll"
    uuid: "fb023c31-d842-422d-ad7e-79ce1db23c21"
) #(
    description: {bonus roll after a strike in the last frame cannot score more than 10 points}
    input: #(
        previousRolls: [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10]
        roll: 11
    )
    expected: #(
        error: "Pin count exceeds pins on the lane"
    )
    function: "roll"
    uuid: "6082d689-d677-4214-80d7-99940189381b"
) #(
    description: {two bonus rolls after a strike in the last frame cannot score more than 10 points}
    input: #(
        previousRolls: [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 5]
        roll: 6
    )
    expected: #(
        error: "Pin count exceeds pins on the lane"
    )
    function: "roll"
    uuid: "e9565fe6-510a-4675-ba6b-733a56767a45"
) #(
    description: {two bonus rolls after a strike in the last frame can score more than 10 points if one is a strike}
    input: #(
        previousRolls: [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 10 6]
    )
    expected: 26
    function: "score"
    uuid: "2f6acf99-448e-4282-8103-0b9c7df99c3d"
) #(
    description: {the second bonus rolls after a strike in the last frame cannot be a strike if the first one is not a strike}
    input: #(
        previousRolls: [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 6]
        roll: 10
    )
    expected: #(
        error: "Pin count exceeds pins on the lane"
    )
    function: "roll"
    uuid: "6380495a-8bc4-4cdb-a59f-5f0212dbed01"
) #(
    description: {second bonus roll after a strike in the last frame cannot score more than 10 points}
    input: #(
        previousRolls: [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 10]
        roll: 11
    )
    expected: #(
        error: "Pin count exceeds pins on the lane"
    )
    function: "roll"
    uuid: "2b2976ea-446c-47a3-9817-42777f09fe7e"
) #(
    description: "an unstarted game cannot be scored"
    input: #(
        previousRolls: []
    )
    expected: #(
        error: "Score cannot be taken until the end of the game"
    )
    function: "score"
    uuid: "29220245-ac8d-463d-bc19-98a94cfada8a"
) #(
    description: "an incomplete game cannot be scored"
    input: #(
        previousRolls: [0 0]
    )
    expected: #(
        error: "Score cannot be taken until the end of the game"
    )
    function: "score"
    uuid: "4473dc5d-1f86-486f-bf79-426a52ddc955"
) #(
    description: "cannot roll if game already has ten frames"
    input: #(
        previousRolls: [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0]
        roll: 0
    )
    expected: #(
        error: "Cannot roll after game is over"
    )
    function: "roll"
    uuid: "2ccb8980-1b37-4988-b7d1-e5701c317df3"
) #(
    description: {bonus rolls for a strike in the last frame must be rolled before score can be calculated}
    input: #(
        previousRolls: [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10]
    )
    expected: #(
        error: "Score cannot be taken until the end of the game"
    )
    function: "score"
    uuid: "4864f09b-9df3-4b65-9924-c595ed236f1b"
) #(
    description: {both bonus rolls for a strike in the last frame must be rolled before score can be calculated}
    input: #(
        previousRolls: [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 10]
    )
    expected: #(
        error: "Score cannot be taken until the end of the game"
    )
    function: "score"
    uuid: "537f4e37-4b51-4d1c-97e2-986eb37b2ac1"
) #(
    description: {bonus roll for a spare in the last frame must be rolled before score can be calculated}
    input: #(
        previousRolls: [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 7 3]
    )
    expected: #(
        error: "Score cannot be taken until the end of the game"
    )
    function: "score"
    uuid: "8134e8c1-4201-4197-bf9f-1431afcde4b9"
) #(
    description: "cannot roll after bonus roll for spare"
    input: #(
        previousRolls: [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 7 3 2]
        roll: 2
    )
    expected: #(
        error: "Cannot roll after game is over"
    )
    function: "roll"
    uuid: "9d4a9a55-134a-4bad-bae8-3babf84bd570"
) #(
    description: "cannot roll after bonus rolls for strike"
    input: #(
        previousRolls: [0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 10 3 2]
        roll: 2
    )
    expected: #(
        error: "Cannot roll after game is over"
    )
    function: "roll"
    uuid: "d3e02652-a799-4ae3-b53b-68582cc604be"
)]


foreach c-case canonical-cases [
	case-code: copy []
	
	foreach previous-roll c-case/input/previousRolls [
		append case-code compose [
			roll (previous-roll)
		]
	]
	
	either all [
		map? c-case/expected
		string? c-case/expected/error
	] [
		append case-code compose/only [
			expect-error/message
				'user
				(switch c-case/function [
					"roll"  [compose [roll (c-case/input/roll)]]
					"score" [[score]]
				])
				(c-case/expected/error)
		]
	] [
		append case-code compose [
			expect (c-case/expected) [score]
		]
	]

	test c-case/description case-code
]

test-results/print
