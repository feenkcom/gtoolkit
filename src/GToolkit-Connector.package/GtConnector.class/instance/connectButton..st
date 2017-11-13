private
connectButton: newButton
	| sourceMethodElement |
	self assert: [ newButton button parent isNil ].	
	newButton button 
		when: BlElementAddedEvent
		do: [ :addedEvent | 
			sourceMethodElement := self elementWithMethod: newButton source ifPresent: [ :x | x ].
			self 
				elementWithMethod: newButton target 
				ifPresent: [ :targetMethodElement | 
					| line edge |
					line := BlLineElement new.
					line constraints ignoreByLayout.
					line
						border: (BlBorder paint: (Color gray alpha: 0.2) width: 5);
						wantsMouse: false;
						fromAnchor: (BlElementCenterAnchor element: newButton button);
						toAnchor: (BlElementLeftCenterAnchor element: targetMethodElement).
					newButton button
						when: BlElementRemovedEvent 
						do: [ :event | line removeFromParent ].
					self addChild: line.
					edge := GtGraphEdge new
						from: sourceMethodElement
						to: targetMethodElement.
					newButton button constraints graph addConnectedEdge: edge.
					targetMethodElement constraints graph addConnectedEdge: edge ] ]