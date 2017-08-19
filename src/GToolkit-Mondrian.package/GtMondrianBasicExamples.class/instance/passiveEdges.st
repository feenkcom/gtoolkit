examples
passiveEdges
	<gtExample>
	| view |
	view := GtMondrian new.
	view shape: [ :x | 
		BlTextElement new text: (BrRopedText string: x asString) ].
	view nodes: (1 to: 100).
	view edges connectFrom: [ :x | x // 2 ].
	view shape: [ :x |
		BlLineElement new
			border: (BlBorder paint: Color red width: 2)  ].
	view edges passive; connect: { 1->12 . 11 -> 19 } from: #key to: #value.
	view layout: (GtGraphHorizontalDominanceTreeLayout new).
	^ view