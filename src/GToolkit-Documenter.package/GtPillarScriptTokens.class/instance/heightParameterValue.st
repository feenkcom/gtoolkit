accessing - parameter values
heightParameterValue
	<return: #String>
	^ self 
		valueOf: self heightParameterName
		value: [ :aString | (Number readFromString: aString) ]
		emptyValue: [ nil ]
		defaultValue: [ nil ]