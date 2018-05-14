accessing - parameter values
epiceaParameterValue
	<return: #FileReference>
	^ self 
		valueOf: self epiceaParameterName
		value: [ :aString | 
			GtFileUtility fileReferenceOfFileName: aString relativeTo: self sourceDirectory ]
		emptyValue: [ nil ]
		defaultValue: [ nil ]