children hooks
connectButtons: newButtons
	newButtons do: [ :newButton |
		| targetMethod |
		targetMethod := newButton button userData at: #buttonAttributeTarget.
		self children 
			detect: [ :each | each userData at: #editedMethod ifPresent: [ :editedMethod | targetMethod = editedMethod ] ifAbsent: [ false ] ]
			ifFound: [ :targetMethodElement | 
				| line edge |
				line := BlLineElement new border: (BlBorder paint: (Color gray alpha: 0.2) width: 5).
				line
					wantsMouse: false;
					fromAnchor: (BlElementCenterAnchor element: newButton button);
					toAnchor: (BlElementLeftCenterAnchor element: targetMethodElement).
				line constraints ignoreByLayout.
				self addChild: line.
				"edge := GtGraphEdge new from: (newButton button
							deep: #parent
							select: [ :each | each isKindOf: BrEditorElement ]) first to: targetMethodElement.
				newButton button constraints graph addConnectedEdge: edge.
				targetMethodElement constraints graph addConnectedEdge: edge"
				] ].
		