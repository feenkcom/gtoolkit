tutorial - nesting
nestedNodes
	<gtExample>
	| view |
	view := self emptyView.
	view nodes
		shape: [ :x | 
			BlElement new 
				geometry: BlEllipse new; 
				background: (BlBackground paint: Color paleOrange);
				constraintsDo: [ :c | c padding: (BlInsets all: 10) ] ];
		with: (1 to: 9)
		forEach: [ :each |
			view nodes 
				shape: [ :x | BlTextElement new text: (x asString asRopedText attributes: {BrTextForegroundAttribute paint: Color gray}) ];
				with: (10 * each to: (10 * each + 4)).
			view layout circle radius: 20 ].
	^ view