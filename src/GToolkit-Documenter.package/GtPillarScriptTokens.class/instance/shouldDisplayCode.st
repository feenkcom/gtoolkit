accessing - parameter values
shouldDisplayCode
	<return: #Boolean>
	^ self booleanValueOf: self codeParameterName emptyValue: true defaultValue: [ 
		(self booleanValueOf: self noCodeParameterName emptyValue: true defaultValue: false) not ]