accessing
edges: aCollection
	edges := aCollection asOrderedCollection.
	self shouldSetDefaultAttachPoint
		ifTrue: [ self addDefaultAttachPointToEdges ]