accessing - parameter values
shouldBeExpanded
	<return: #Boolean>
	^ self 
		booleanValueOf: self expandedParameterName
		emptyValue: true
		defaultValue: true