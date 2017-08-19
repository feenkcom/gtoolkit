reversing
inverseAttachPointIfNecessary
	"Inverse the attach point if the user has not used #doNotAttachPoint"
	self shouldSetDefaultAttachPoint
		ifTrue: [ self inverseAttachPoint ]