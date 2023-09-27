Red [
	Title:   "PNG codec"
	Author:  "Qingtian Xie"
	File:	 %PNG.red
	Tabs:	 4
	Rights:  "Copyright (C) 2015-2018 Red Foundation. All rights reserved."
	License: {
		Distributed under the Boost Software License, Version 1.0.
		See https://github.com/red/red/blob/master/BSL-License.txt
	}
]

put system/codecs 'png context [
	title: ""
	name: 'PNG
	mime-type: [image/png]
	suffixes: [%.png]
	
	encode: routine [img [image!] where [any-type!]][
		#if not find [Android FreeBSD NetBSD Syllabe] OS [
			stack/set-last as cell! image/encode img where IMAGE_PNG
		]
	]

	decode: routine [data [any-type!]][
		#if not find [Android FreeBSD NetBSD Syllabe] OS [
			stack/set-last as cell! image/decode data
		]
	]
]