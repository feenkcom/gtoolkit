scripting - shape
umlClassShapeWithName: aBlock
	self shape: [ :each | 
		GtMondrianUMLClassElement withDefaultContainer 
			label: each asString ]