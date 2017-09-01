examples
nestedNodesWithGlobalEdges
	<gtExample>
	| view |
	view := GtMondrian new.
	view nodes
		shape: [ :each | 
			BlElement new
				border: (BlBorder paint: Color black width: 2);
				constraintsDo: [ :constraints | constraints padding: (BlInsets all: 10) ] ].
	view nodes
		with:
			{(1 to: 3).
			(4 to: 6)}
		forEach: [ :collection | 
			view nodes
				shape: [ :x | BlTextElement new text: (BrRopedText string: x asString) ];
				for: collection.
			view layout circle ].
	view edges
		connect:
			{(1 -> 2).
			(3 -> 1).
			(1 -> 4).
			(4 -> 6).
			(5 -> 6)}
		from: [ :x | x key ]
		to: [ :x | x value ].
	view layout circle radius: 100.
	^ view