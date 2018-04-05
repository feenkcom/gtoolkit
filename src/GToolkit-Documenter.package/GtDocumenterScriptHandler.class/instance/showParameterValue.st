accessing
showParameterValue
	<return: #Symbol or: nil>
	^ self scriptParameters
		at: self class showParameterName
		ifPresent: [ :selector | selector asSymbol ]
		ifAbsent: [ nil ]