initialization
initialize
	super initialize.
	self scriptParameters: Dictionary new.
	self scriptParameters 
		at: self class showParameterName
		put: 'gtPrintIn:'