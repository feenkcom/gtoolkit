examples
nestedWithEdges
	<gtExample>
	| view |
	view := GtMondrian new.
	view shape: [ :each | 
		BlElement new 	
			border: (BlBorder paint: Color black width: 2);
			constraintsDo: [ :constraints |
				constraints padding: (BlInsets all: 10) ] ].
	view nodes: (1 to: 10) forEach: [ :each | 
		view shape: [ :x | 
			BlTextElement new text: (BrRopedText string: x asString) ].
		view nodes: (1 to: each).
		view edges connect: (1 to: each) from: [ :x | x // 2 ] to: [ :x | x ].
		view layout: (BlGraphRadialTreeLayout new). ].
	view layout: (BlGraphCircleLayout new radius: 200).
	^ view