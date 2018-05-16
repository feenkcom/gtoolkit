initialization
initialize
	super initialize.
	document := GtNullDocument uniqueInstance.
	announcer := Announcer new.
	isRegistered := false.
	self class finalizationRegistry add: self.