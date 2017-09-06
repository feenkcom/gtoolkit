scripting - shape
umlClassShapeWithName: aBlock andTextAttributes: aTextAttributesBlock
	self shape: [ :anObject |
		GtMondrianUMLClassElement withDefaultContainer 
			label: (aBlock value: anObject);
			labelAttributes: (aTextAttributesBlock value: anObject) ]