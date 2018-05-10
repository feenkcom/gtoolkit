accessing - parameter values
labelParameterValue
	<return: #String>
	^ self 
		valueOf: self labelParameterName
		emptyValue: [ GtDocumenterConstants defaultExecuteButtonLabel ]
		defaultValue: [ GtDocumenterConstants defaultExecuteButtonLabel ]