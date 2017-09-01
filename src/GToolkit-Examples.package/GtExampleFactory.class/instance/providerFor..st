private-utils
providerFor: aCompiledMethod
	^ provider ifNil: [ self defaultProviderFor: aCompiledMethod ]