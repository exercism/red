REBOL [
  	Title:   "Red Run All Together Initialisation "
	Author:  "Peter W A Wood"
	Version: 0.1.0
	Tabs:	 4
	Rights:  "Copyright (C) 2015 Peter W A Wood. All rights reserved."
	License: "BSD-3 - https://github.com/red/red/blob/origin/BSD-3-License.txt"
	Purpose: {Defines tests to be run in red/run-all.r and red/tests/run-all.r}
]

;; make auto files if needed
do %make-red-auto-tests.r
do %make-interpreter-auto-tests.r

;; build run-all-together.red
do %make-run-all-red-together.r
