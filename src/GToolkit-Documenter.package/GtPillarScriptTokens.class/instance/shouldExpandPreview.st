accessing - parameter values
shouldExpandPreview
	<return: #Boolean>
	^ self 
		booleanValueOf: self expandedPreviewParameterName
		emptyValue: true
		defaultValue: false