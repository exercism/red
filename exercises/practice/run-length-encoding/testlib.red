Red [
	description: {Unit testing library}
	author: "loziniak"
]


context [
	tested: 0
	ignore-after: none
	test-file: none
	
	set 'test-init function [
		file [file!]
		/limit
			ia [integer!]
	] [
		self/test-file: file
		if limit [
			self/ignore-after: ia
		]
	]

	sandbox!: context [
	
		expect: function [
			expectation
			code [block!]
		] [
			result: try [
				catch code
			]
		
			if error? result [
				either result/type = 'user [
					result: make map! reduce ['error result/arg1]
				] [
					throw result
				]
			]
		
			unless result = expectation [
				throw rejoin [{FAILED. Expected: } expectation {, but got } result]
			]
			
			result
		]
	]

	set 'test function [
		summary [string!]
		code [block!]
		/extern
			tested
	] [
		unless any [
			none? ignore-after
			tested < ignore-after
		] [
			print ["(ingored)" summary]
			return none
		]
		
		exercise: make sandbox! load test-file

		code: bind code exercise
	
		result: catch [
			do code
			"✓"
		]
	
		print [
			pad/with summary 40 #"."
			result
		]

		tested: tested + 1
	]

]
