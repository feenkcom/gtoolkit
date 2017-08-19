instance creation
withCode: shouldShowCode
	"Create and return an example element that also shows example's
	code if true is given"
	<return: #GtPillarExampleElement>
	
	^ shouldShowCode
		ifTrue: [ GtPillarExampleWithCodeElement new ]
		ifFalse: [ GtPillarExampleWithoutCodeElement new ]