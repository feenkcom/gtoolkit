accessing
uniqueInstance
	^ uniqueInstance ifNil: [ uniqueInstance := self new ]