accessing - parameter values
epiceaParameterStringValue
	<return: #String>
	^ self 
		valueOf: self epiceaParameterName
		emptyValue: [ nil ]
		defaultValue: [ nil ]