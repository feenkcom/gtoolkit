examples
nestedNodesOn: view
	<gtExample>
	<dependsOn: #emptyView>
	view nodes
		shape: [ :each | 
			BlElement new
				border: (BlBorder paint: Color black width: 2);
				constraintsDo: [ :constraints | constraints padding: (BlInsets all: 10) ] ];
		with: (1 to: 10)
			forEach: [ :each | 
			view nodes
				shape: [ :x | BlTextElement new text: (BrRopedText string: x asString) ];
				for: (1 to: each).
			view layout grid gapSize: 5 ].
	view layout circle radius: 200.
	^ view