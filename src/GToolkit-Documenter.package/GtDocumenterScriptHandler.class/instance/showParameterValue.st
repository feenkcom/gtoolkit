accessing
showParameterValue
	<return: #Symbol or: nil>
	^ tokens scriptParameters
		at: self class showParameterName
		ifPresent: [ :selector | selector asSymbol ]
		ifAbsent: [ nil ]