*GToolkit-Mondrian
mondrianChildrenContainers
	^ self userData 
		at: #mondrianChildrenContainers
		ifAbsentPut: [ Dictionary new ]