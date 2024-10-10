Red [
	description: {Tests for "Bottle Song" Exercism exercise}
	author: "loziniak"
]

#include %testlib.red

test-init/limit %bottle-song.red 1
; test-init/limit %.meta/example.red 1						; test example solution

canonical-cases: [#[
	description: "first generic verse"
	input: #[
		startBottles: 10
		takeDown: 1
	]
	expected:
{Ten green bottles hanging on the wall,
Ten green bottles hanging on the wall,
And if one green bottle should accidentally fall,
There'll be nine green bottles hanging on the wall.}
	function: "recite"
	uuid: "d4ccf8fc-01dc-48c0-a201-4fbeb30f2d03"
] #[
	description: "last generic verse"
	input: #[
		startBottles: 3
		takeDown: 1
	]
	expected:
{Three green bottles hanging on the wall,
Three green bottles hanging on the wall,
And if one green bottle should accidentally fall,
There'll be two green bottles hanging on the wall.}
	function: "recite"
	uuid: "0f0aded3-472a-4c64-b842-18d4f1f5f030"
] #[
	description: "verse with 2 bottles"
	input: #[
		startBottles: 2
		takeDown: 1
	]
	expected:
{Two green bottles hanging on the wall,
Two green bottles hanging on the wall,
And if one green bottle should accidentally fall,
There'll be one green bottle hanging on the wall.}
	function: "recite"
	uuid: "f61f3c97-131f-459e-b40a-7428f3ed99d9"
] #[
	description: "verse with 1 bottle"
	input: #[
		startBottles: 1
		takeDown: 1
	]
	expected:
{One green bottle hanging on the wall,
One green bottle hanging on the wall,
And if one green bottle should accidentally fall,
There'll be no green bottles hanging on the wall.}
	function: "recite"
	uuid: "05eadba9-5dbd-401e-a7e8-d17cc9baa8e0"
] #[
	description: "first two verses"
	input: #[
		startBottles: 10
		takeDown: 2
	]
	expected:
{Ten green bottles hanging on the wall,
Ten green bottles hanging on the wall,
And if one green bottle should accidentally fall,
There'll be nine green bottles hanging on the wall.

Nine green bottles hanging on the wall,
Nine green bottles hanging on the wall,
And if one green bottle should accidentally fall,
There'll be eight green bottles hanging on the wall.}
	function: "recite"
	uuid: "a4a28170-83d6-4dc1-bd8b-319b6abb6a80"
] #[
	description: "last three verses"
	input: #[
		startBottles: 3
		takeDown: 3
	]
	expected:
{Three green bottles hanging on the wall,
Three green bottles hanging on the wall,
And if one green bottle should accidentally fall,
There'll be two green bottles hanging on the wall.

Two green bottles hanging on the wall,
Two green bottles hanging on the wall,
And if one green bottle should accidentally fall,
There'll be one green bottle hanging on the wall.

One green bottle hanging on the wall,
One green bottle hanging on the wall,
And if one green bottle should accidentally fall,
There'll be no green bottles hanging on the wall.}
	function: "recite"
	uuid: "3185d438-c5ac-4ce6-bcd3-02c9ff1ed8db"
] #[
	description: "all verses"
	input: #[
		startBottles: 10
		takeDown: 10
	]
	expected:
{Ten green bottles hanging on the wall,
Ten green bottles hanging on the wall,
And if one green bottle should accidentally fall,
There'll be nine green bottles hanging on the wall.

Nine green bottles hanging on the wall,
Nine green bottles hanging on the wall,
And if one green bottle should accidentally fall,
There'll be eight green bottles hanging on the wall.

Eight green bottles hanging on the wall,
Eight green bottles hanging on the wall,
And if one green bottle should accidentally fall,
There'll be seven green bottles hanging on the wall.

Seven green bottles hanging on the wall,
Seven green bottles hanging on the wall,
And if one green bottle should accidentally fall,
There'll be six green bottles hanging on the wall.

Six green bottles hanging on the wall,
Six green bottles hanging on the wall,
And if one green bottle should accidentally fall,
There'll be five green bottles hanging on the wall.

Five green bottles hanging on the wall,
Five green bottles hanging on the wall,
And if one green bottle should accidentally fall,
There'll be four green bottles hanging on the wall.

Four green bottles hanging on the wall,
Four green bottles hanging on the wall,
And if one green bottle should accidentally fall,
There'll be three green bottles hanging on the wall.

Three green bottles hanging on the wall,
Three green bottles hanging on the wall,
And if one green bottle should accidentally fall,
There'll be two green bottles hanging on the wall.

Two green bottles hanging on the wall,
Two green bottles hanging on the wall,
And if one green bottle should accidentally fall,
There'll be one green bottle hanging on the wall.

One green bottle hanging on the wall,
One green bottle hanging on the wall,
And if one green bottle should accidentally fall,
There'll be no green bottles hanging on the wall.}
	function: "recite"
	uuid: "28c1584a-0e51-4b65-9ae2-fbc0bf4bbb28"
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
