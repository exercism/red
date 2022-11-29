Red [
	description: {Unit testing library}
	author: "loziniak"
]


context [
	tested: ignore-after: test-file: results: output: none
	
	set 'test-init function [
		file	[file!]
		/limit
			ia	[integer!]
	] [
		self/tested: 0
		self/ignore-after: either limit [ia] [none]
		self/test-file: file
		self/results: copy []
		self/output: copy ""
	]

	sandbox!: context [
	
		assert: function [
			code [block!]
			/local result
		] [
			res: last results

			set/any 'result do code
			either :result = true [
				res/status: 'pass
			] [
				res/status: 'fail
				throw/name none 'expect-fail
			]
			
			:result
		]
	
		expect: function [
			expectation [any-type!]
			code [block!]
			/local result
		] [
			res: last results
			res/expected: :expectation

			set/any 'result do code
			res/actual: :result
		
			either :result = :expectation [
				res/status: 'pass
			] [
				res/status: 'fail
				throw/name none 'expect-fail
			]
			
			:result
		]

		expect-error: function [
			type	[word!]
			code	[block!]
			/message
				msg	[string!]
			/local result result-or-error
		] [
			returned-error?: no
			set/any 'result-or-error try [
				set/any 'result do code
				returned-error?: yes
				:result
			]

			res: last results
			res/actual: :result-or-error
			res/expected: compose [type: (type)]
			if message [append res/expected compose [id: 'message arg1: (msg)]]
			
			either all [
				error? :result-or-error
				not returned-error?
				result-or-error/type = type
				any [
					not message
					all [
						result-or-error/id = 'message
						result-or-error/arg1 = msg
					]
				]
			] [
				res/status: 'pass
			] [
				res/status: 'fail
				throw/name none 'expect-fail
			]
			
			:result-or-error
		]
	]

	set 'test function [
		summary [string!]
		code [block!]
		/extern
			tested
	] [
		append results result: make map! compose/only [
			summary: (summary)				;@@ [string!]
			test-code: (copy code)			;@@ [block!]
			status: none					;@@ [word!] : 'pass | 'fail | 'error | 'ignored
			;-- expected					(optional field)
			;-- actual						(optional field)
			;-- output						(optional field)
		]
	
		either any [
			none? ignore-after
			tested < ignore-after
		] [
			clear output
			old-functions: override-console
		
			exercise: make sandbox! load test-file
			code: bind code exercise
			uncaught?: yes
			outcome: catch [
				outcome: try [
					catch/name [
						do code
					] 'expect-fail
					none
				]
				uncaught?: no
				outcome
			]			
			
			case [
				error? outcome [
					result/status: 'error
					result/actual: outcome
				]
				uncaught? [
					result/status: 'error
					result/actual: make error! [type: 'throw id: 'throw arg1: outcome]
				]
			]

			restore-console old-functions
			result/output: copy output
		] [
			result/status: 'ignored
		]

		tested: tested + 1
	]
	
	set 'test-results function [
		/print
	] [
		either print [
			foreach result self/results [
				system/words/print rejoin [
					pad/with result/summary 40 #"."
					"... "
					switch result/status [
						pass	["✓"]
						fail	[rejoin [
								{FAILED.}
								either find result 'expected [rejoin [
									{ Expected: } result/expected
									either find result 'actual [rejoin [
										{, but got } result/actual
									]] []
								]] []
								newline
								result/output
							]]
						error	[rejoin [
								newline
								result/output
								form result/actual
							]]
						ignored	["(ignored)"]
					]
				]
			]
		] [
			self/results
		]
	]


	override-console: function [] [
		old-functions: reduce [:prin :print :probe]

		system/words/prin: function [value [any-type!]] [
			append self/output form :value
			return ()
		]
		system/words/print: function [value [any-type!]] [
			append self/output reduce [form :value #"^/"]
			return ()
		]
		system/words/probe: function [value [any-type!]] [
			append self/output reduce [mold :value #"^/"]
			return :value
		]
		return old-functions
	]

	restore-console: function [old-functions [block!]] [
		set [prin print probe] old-functions
	]

]
