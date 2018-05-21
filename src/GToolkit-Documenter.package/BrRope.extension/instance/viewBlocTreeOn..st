*GToolkit-Documenter
viewBlocTreeOn: view
	view nodes
		shape: [ :each | 
			(each isKindOf: BrCollectionRope)
				ifTrue: [
					BlTextElement new 
						zIndex: 10;
						background: Color white;
						constraintsDo: [ :c | c padding: (BlInsets all: 5) ];
						text: each asString asRopedText ]
				ifFalse: [ 
					BlElement new 
						zIndex: 10;
						geometry: BlEllipse new;
						border: (BlBorder paint: Color black width: 1);
						background: Color white;
						size: 10@10 ] ];
		with: (self withDeepCollect: #children).
	view edges
		shape: [ :each | BlLineElement new border: (BlBorder paint: (Color gray alpha: 0.5) width: 1 ) ];
		connectToAll: #children.
	view layout tree 
		horizontalGap: 20;
		verticalGap: 40