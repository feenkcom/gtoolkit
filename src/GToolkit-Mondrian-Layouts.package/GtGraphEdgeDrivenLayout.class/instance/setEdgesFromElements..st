accessing
setEdgesFromElements: elements 

	elements isEmpty
		ifTrue: [ ^ self ].
	^ self
		edges:
			((elements flatCollect: [ :each | each constraints graph incomingEdges ])
				select: [ :anEdge | (elements includes: anEdge fromElement) ])