private-utils
providerFor: aCompiledMethod do: aBlock1 ifNone: aBlock2
	^ (self providerFor: aCompiledMethod)
		ifNotNil: aBlock1
		ifNil: aBlock2