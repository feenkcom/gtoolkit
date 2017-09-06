scripting - shape
umlClassShapeWithName: aBlock
	self shape: [ :each | 
		GtMondrianUMLClassElement new 
			newContainers: #(one two); 
			label: each asString ]