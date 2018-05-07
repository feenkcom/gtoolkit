accessing - parameter values
exampleParameterValue
	<return: #String>
	^ self 
		valueOf: self exampleParameterName
		value: [ :aString | aString ]
		emptyValue: [ nil ]
		defaultValue: [ nil ]