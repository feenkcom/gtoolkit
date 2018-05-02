accessing
isAssertionEnabled
	^ isAssertionEnabled ifNil: [ isAssertionEnabled := true ]