public
openMethod: aMethod relativeTo: aSourceElement linkedTo: anElement
	"Open a given method connecting newly created editor with the provided source element"
	| aTargetElement |
	
	self
		assert: [ (self hasOpenedMethod: aMethod) not ]
		description: [ 'Can not open already opened method' ].

	aTargetElement := self addMethod: aMethod.
	"we should directly connect two element with an edge.
	We can only connect editors (not button and editor!), since they are my direct children"
	self addEdgeFrom: aSourceElement to: aTargetElement.
	self addLineFrom: anElement to: aTargetElement.
	
	self flag: 'here we should find all buttons with aMethod as target and connect them'