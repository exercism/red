Red [
	description: {"SGF Parsing" exercise solution for exercism}
	author: "dander"
	sgf-ebnf: {
		Collection = GameTree { GameTree }
		GameTree   = "(" Sequence { GameTree } ")"
		Sequence   = Node { Node }
		Node       = ";" { Property }
		Property   = PropIdent PropValue { PropValue }
		PropIdent  = UcLetter { UcLetter }
		PropValue  = "[" CValueType "]"
		CValueType = (ValueType | Compose)
		ValueType  = (None | Number | Real | Double | Color | SimpleText | Text | Point | Move | Stone)
	}
]

make-node: func [][
	make map! compose/only [properties: (copy #[]) children: (copy [])]
]

unescape: func [value][
	rejoin parse value [collect any [keep "\n" | "\t" keep (" ") | ["\" keep skip] | keep skip]]
]

input-error: func [error-msg] [do make error! error-msg]

parse-sgf: function [{
	Parse a single gametree, and produce the following Red structure:
	game-tree => #( properties: ... children: ...)
	node => #( name: value ...) -- a map of property name/value pairs, representing a 'node'
	children => [...] -- a block of child game-trees
}
	encoded "sgf-formated gametree"
][
	if empty? encoded [input-error "tree missing"]

	game-tree: [
		#"(" (insert/only tree-stack node-sequence)
		[some node | (input-error "tree with no nodes")]
		any game-tree
		#")" (node-sequence: take tree-stack)
	]
	node: [#";" (
		append node-sequence cur-node: make-node
		node-sequence: cur-node/children
		)
		any property
	]
	property: [prop-name [some prop-value | (input-error "properties without delimiter")]]
	prop-name: [copy name value (
		unless name == uppercase copy name [input-error "property must be in uppercase"]
		put :cur-node/properties to word! :name cur-prop: copy []
	)]
	prop-value: [ #"[" copy val value #"]" (append :cur-prop unescape :val)]
	value: [some [escaped | not specials skip]]
	escaped: [#"\" skip]
	specials: charset "()[];"

	tree-stack: copy []
	root: node-sequence: copy []
	insert/only tree-stack node-sequence
	
	parse encoded [game-tree | (input-error "tree missing")]

	return first root
]

