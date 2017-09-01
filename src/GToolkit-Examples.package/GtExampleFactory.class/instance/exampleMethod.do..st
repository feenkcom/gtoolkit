private
exampleMethod: aCompiledMethod do: aBlock
	(self isExampleMethod: aCompiledMethod) ifFalse: [ ^ self ].
	self exampleFromMethod: aCompiledMethod do: aBlock