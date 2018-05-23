accessing - parameter values
showParameterValue
	<return: #Symbol or: nil>
	^ self 
		valueOf: self showParameterName
		value: [ :selector | selector asSymbol ]
		emptyValue: [ GtDocumenterConstants defaultShowMethodName ]
		defaultValue: [ GtDocumenterConstants defaultShowMethodName ]