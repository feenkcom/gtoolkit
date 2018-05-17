initialization
initialize
	super initialize.
	announcer := Announcer new.
	isRegistered := false.
	self class finalizationRegistry add: self.