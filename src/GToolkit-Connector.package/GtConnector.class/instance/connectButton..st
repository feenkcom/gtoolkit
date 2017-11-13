private
connectButton: aTextActionButtonAttribute
	| sourceMethodElement |
	self
		assert: [ aTextActionButtonAttribute button hasParent not ]
		description: [ 'Button not must have a parent' ].
	
	aTextActionButtonAttribute button 
		when: BlElementAddedEvent
		do: [ :addedEvent | 
			sourceMethodElement := self elementWithMethod: aTextActionButtonAttribute source ifPresent: [ :x | x ].
			self 
				elementWithMethod: aTextActionButtonAttribute target 
				ifPresent: [ :targetMethodElement | 
					| line edge |
					line := BlLineElement new.
					line constraints ignoreByLayout.
					line
						border: (BlBorder paint: (Color gray alpha: 0.2) width: 5);
						wantsMouse: false;
						fromAnchor: (BlElementCenterAnchor element: aTextActionButtonAttribute button);
						toAnchor: (BlElementLeftCenterAnchor element: targetMethodElement).
					aTextActionButtonAttribute button
						when: BlElementRemovedEvent 
						do: [ :event | line removeFromParent ].
					self addChild: line.
					edge := GtGraphEdge new
						from: sourceMethodElement
						to: targetMethodElement.
					aTextActionButtonAttribute button constraints graph addConnectedEdge: edge.
					targetMethodElement constraints graph addConnectedEdge: edge ] ]