accessing - parameter values
valueOf: aString emptyValue: emptyBlock defaultValue: defaultBlock
	^ self 
		valueOf: aString 
		value: [ :aValueString | aValueString ] 
		emptyValue: emptyBlock 
		defaultValue: defaultBlock