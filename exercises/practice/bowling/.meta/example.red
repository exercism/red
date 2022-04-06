Red [
	description: {"Bowling" exercise solution for exercism platform}
	author: "loziniak"
]

; running-total: 0

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
						finished?: yes
					]
				]
				1 [
					if not strike? [
						case [
							10 < (pins + rolls/1) [] ;@@ TODO: error - impossible to knock down > 10 pins
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
					finished?: yes
				]
			]
		] [
			if 0 < length? rolls [
				if 10 < (pins + rolls/1) [] ;@@ TODO: error - impossible to knock down > 10 pins
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
	sum: 0
	add-to-strike: 0
	add-to-spare: 0
	foreach frame frames [
		foreach pins frame/rolls [
			sum: sum + pins
			if add-to-strike > 0 [
				sum: sum + pins
				add-to-strike: add-to-strike - 1
			]
			if add-to-spare > 0 [
				sum: sum + pins
				add-to-spare: add-to-spare - 1
			]
		]
		if frame/strike? [add-to-strike: 2]
		if frame/spare? [add-to-spare: 1]
	]
	sum
]

roll: function [
	pins [integer!]
] [
	if any [
		pins > 10
		pins < 0
	] [] ;@@ TODO: error - impossible pins count

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

	frame/roll pins
]
