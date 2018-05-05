accessing - parameter values
booleanValueOf: aString emptyValue: emptyBooleanOrBlock defaultValue: defaultBooleanOrBlock
	^ self 
		valueOf: aString
		value: [ :aValue | 
			(aValue asString asLowercase trimBoth = 'true') or: [ 
				aValue asString trimBoth = '' ] ]
		emptyValue: emptyBooleanOrBlock
		defaultValue: defaultBooleanOrBlock