children hooks
connectButton: newButton
	| sourceMethodElement |
	self children
		detect: [ :each | 
			each userData
				at: #editedMethod
				ifPresent: [ :editedMethod | newButton source = editedMethod ]
				ifAbsent: [ false ] ]
		ifFound: [ :x | sourceMethodElement := x ].
	^ self children
		detect: [ :each | 
			each userData
				at: #editedMethod
				ifPresent: [ :editedMethod | newButton target = editedMethod ]
				ifAbsent: [ false ] ]
		ifFound: [ :targetMethodElement | 
			| line edge |
			line := BlLineElement new
				border: (BlBorder paint: (Color gray alpha: 0.2) width: 5).
			line
				wantsMouse: false;
				fromAnchor: (BlElementCenterAnchor element: newButton button);
				toAnchor: (BlElementLeftCenterAnchor element: targetMethodElement).
			line constraints ignoreByLayout.
			self addChild: line.
			edge := GtGraphEdge new
				from: sourceMethodElement
				to: targetMethodElement.
			newButton button constraints graph addConnectedEdge: edge.
			targetMethodElement constraints graph addConnectedEdge: edge ]