utility - debugging
ifDebugMode: aBlock
	self isDebuggingEnabled ifTrue: [ aBlock value ]