Red/System [
	Title:	"Windows events handling"
	Author: "Nenad Rakocevic"
	File: 	%panel.reds
	Tabs: 	4
	Rights: "Copyright (C) 2015-2018 Red Foundation. All rights reserved."
	License: {
		Distributed under the Boost Software License, Version 1.0.
		See https://github.com/red/red/blob/master/BSL-License.txt
	}
]

init-panel: func [
	values [red-value!]
	phWnd  [handle!]									;-- parent window handle
	/local
		parent	  [red-object!]
		type	  [red-word!]
		pair	  [red-pair!]
		win-rect  [RECT_STRUCT value]
		calc-rect [RECT_STRUCT value]
		x		  [integer!]
		y		  [integer!]
][
	parent: as red-object! values + FACE_OBJ_PARENT

	if TYPE_OF(parent) = TYPE_OBJECT [
		type: as red-word! get-node-facet parent/ctx FACE_OBJ_TYPE

		if tab-panel = symbol/resolve type/symbol [
			GetClientRect phWnd win-rect
			copy-memory 
				as byte-ptr! calc-rect
				as byte-ptr! win-rect
				size? win-rect
			SendMessage phWnd TCM_ADJUSTRECT 0 as-integer calc-rect

			pair: as red-pair! values + FACE_OBJ_OFFSET
			x: calc-rect/left - win-rect/left
			y: calc-rect/top  - win-rect/top
			either dpi-factor <> 100 [
				pair/x: x * 100 / dpi-factor
				pair/y: y * 100 / dpi-factor
			][
				pair/x: x - 3
				pair/y: y - 1
			]

			pair: as red-pair! values + FACE_OBJ_SIZE
			x: calc-rect/right  - calc-rect/left
			y: calc-rect/bottom - calc-rect/top
			either dpi-factor <> 100 [
				pair/x: x * 100 / dpi-factor
				pair/y: y * 100 / dpi-factor
			][
				pair/x: x + 4
				pair/y: y + 3
			]
		]
	]
]