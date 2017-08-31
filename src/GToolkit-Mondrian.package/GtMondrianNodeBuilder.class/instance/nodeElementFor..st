instance creation
nodeElementFor: anObject
		| nodeElement |
	nodeElement := elementBlock 
		ifNotNil: [ elementBlock cull: anObject cull: self defaultNodeElement ]
		ifNil: [ self defaultNodeElement ].
	nodeElement mondrianModel: anObject.
	nodeElement beMondrianNode.
	^ nodeElement 