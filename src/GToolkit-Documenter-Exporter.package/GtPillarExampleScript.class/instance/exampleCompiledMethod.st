accessing
exampleCompiledMethod
	^ self example ifNotNil: [ :example | Compiler evaluate: example ]