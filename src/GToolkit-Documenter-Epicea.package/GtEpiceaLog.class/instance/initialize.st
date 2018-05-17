initialization
initialize
	super initialize.
	announcer := Announcer new.
	errorHandler := [ :error | | message |
		DebugMode ifTrue: [ error pass ].
		message := 'error on operation: ' , error asString.
		message traceCr.
		self inform: message ].