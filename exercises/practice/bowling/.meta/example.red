Red [
	description: {"Bowling" exercise solution for exercism platform}
	author: "loziniak"
]

frames: copy []

frame!: object [
	rolls: copy []

	finished?: no

	tenth?: no
	spare?: no
	strike?: no

	roll: function [
		pins [integer!]
		/extern finished? tenth? spare? strike?
	] [
		either tenth? [
			switch length? rolls [
				0 [
					if pins = 10 [
						strike?: yes
					]
				]
				1 [
					if not strike? [
						case [
							10 < (pins + rolls/1) [cause-error 'user 'message "Pin count exceeds pins on the lane"]
							10 = (pins + rolls/1) [
								spare?: yes
							]
							10 > (pins + rolls/1) [
								finished?: yes
							]
						]
					]
				]
				2 [
					if all [
						strike?
						10 > rolls/2
						10 < (pins + rolls/2)
					] [
						cause-error 'user 'message "Pin count exceeds pins on the lane"
					]
					finished?: yes
				]
			]
		] [
			if 0 < length? rolls [
				if 10 < (pins + rolls/1) [cause-error 'user 'message "Pin count exceeds pins on the lane"]
				if 10 = (pins + rolls/1) [
					spare?: yes
				]
				finished?: yes
			]
		
			if pins = 10 [
				spare?: (0 < length? rolls)
				strike?: not spare?
				finished?: yes
			]
		]
	
		append rolls pins
	]

]

score: function [
	return: [integer!]
] [
	if any [
		10 > length? frames
		not get in last frames 'finished?
	] [cause-error 'user 'message "Score cannot be taken until the end of the game"]

	sum: 0
	strike-2s: 0
	strike-1s: 0
	spares: 0

	foreach frame frames [
		prin reduce [frame/rolls frame/finished? "  "]
		foreach pins frame/rolls [
			sum: sum + pins
			if spares > 0 [
				sum: sum + pins
				spares: spares - 1
			]
			if strike-1s > 0 [
				sum: sum + pins
				strike-1s: strike-1s - 1
			]
			if strike-2s > 0 [
				sum: sum + pins
				strike-2s: strike-2s - 1
				strike-1s: strike-1s + 1
			]
		]
		if not frame/tenth? [
			if frame/strike? [strike-2s: strike-2s + 1]
			if frame/spare? [spares: spares + 1]
		]
	]
	sum
]

roll: function [
	pins [integer!]
] [
	if pins > 10 [cause-error 'user 'message "Pin count exceeds pins on the lane"]
	if pins < 0 [cause-error 'user 'message "Negative roll is invalid"]

	frame: last frames
	if any [
		none? frame
		frame/finished?
	] [
		frame: make frame! [
			tenth?: 9 = length? frames
		]
		append frames frame
	]
	
	if any [
		10 < length? frames
		all [
			10 = length? frames
			frame/finished?
		]
	] [
		cause-error 'user 'message "Cannot roll after game is over"
	]

	frame/roll pins
]
