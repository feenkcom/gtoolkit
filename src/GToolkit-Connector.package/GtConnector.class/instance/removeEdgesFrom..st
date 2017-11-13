private - adding / removing
removeEdgesFrom: anElement
	"I remove edges associated with the given element and edges from other elements with which it is connected"

	anElement constraints graph connectedEdges
		do: [ :anEdge |
			| aConnectedElement |
			"connected element is an element on the other side of the edge"
			aConnectedElement := (anEdge fromElement == anElement)
				ifTrue: [ anEdge toElement  ]
				ifFalse: [ anEdge fromElement ].
			
			self
				assert: [ aConnectedElement constraints graph hasConnectedEdge: anEdge ]
				description: [ 'Connected element must have the same edge, otherwise something went out of sync' ].

			aConnectedElement constraints graph removeConnectedEdge: anEdge ].
	
	"constraints changed, should update layout"
	self requestLayout