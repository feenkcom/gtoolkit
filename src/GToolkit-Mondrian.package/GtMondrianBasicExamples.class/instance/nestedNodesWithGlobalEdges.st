examples
nestedNodesWithGlobalEdges
	<gtExample>
	| view |
	view := GtMondrian new.
	view shape: [ :each | 
	    BlElement new     
	        border: (BlBorder paint: Color black width: 2);
	        constraintsDo: [ :constraints |
	            constraints padding: (BlInsets all: 10) ] ].
	view nodes: {(1 to: 3) . (4 to: 6)} forEach: [ :collection | 
	    view shape: [ :x | 
	        BlTextElement new text: (BrRopedText string: x asString) ].
	    view nodes: collection.
	    view layout: (BlGraphCircleLayout new radius: 20). ].
	view edges
		connect: { 1 -> 2 . 3 -> 1 . 1 -> 4 . 4 -> 6 . 5 -> 6}
		from: [ :x | x key ] 
		to: [ :x | x value ].
	view layout: (BlGraphCircleLayout new radius: 100).
	^ view