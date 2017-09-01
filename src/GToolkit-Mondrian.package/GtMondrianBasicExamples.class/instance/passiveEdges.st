examples
passiveEdges
	<gtExample>
	| view |
	view := self emptyView.
	view nodes
		shape: [ :x | BlTextElement new text: x asString asRopedText ];
		with: (1 to: 100).
	view edges connectFrom: [ :x | x // 2 ].
	view edges
		shape: [ :x | 
			BlLineElement new
				border: (BlBorder paint: (Color red alpha: 0.5) width: 2) ];
		passive;
		connect:
			{(1 -> 12).
			(11 -> 19)}
			from: #key
			to: #value.
	view layout radialTree.
	^ view