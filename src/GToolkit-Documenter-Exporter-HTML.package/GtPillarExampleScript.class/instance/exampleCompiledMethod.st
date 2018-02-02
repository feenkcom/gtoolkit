accessing
exampleCompiledMethod
	self halt.
	^ Compiler compile: (self parameters at: 'example')