examples
nestedWithEdges
	<gtExample>
	| view |
	view := self emptyView.
	view nodes
		shape: [ :each | 
			BlElement new
				border: (BlBorder paint: Color black width: 2);
				constraintsDo: [ :constraints | constraints padding: (BlInsets all: 10) ] ];
		with: (1 to: 10)
			forEach: [ :each | 
			view nodes
				shape: [ :x | BlTextElement new text: x asString asRopedText ];
				with: (1 to: each).
			view edges
				connect: (1 to: each)
				from: [ :x | x // 2 ]
				to: [ :x | x ].
			view layout radialTree ].
	view layout circle radius: 200.
	^ view