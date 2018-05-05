accessing - parameter values
valueOf: aString value: valueBlock emptyValue: emptyBlock defaultValue: defaultBlock
	^ self scriptParameters 
		at: aString
		ifPresent: [ :aValue | 
			aValue 
				ifNil: [ emptyBlock value ]
				ifNotNil: [ valueBlock cull: aValue ] ]
		ifAbsent: [ defaultBlock value ]