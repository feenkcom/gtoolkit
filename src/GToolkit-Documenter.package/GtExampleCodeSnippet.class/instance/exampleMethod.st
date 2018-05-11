accessing
exampleMethod
	<return: #CompiledMethod>
	^ methodDefinition isDefined
		ifTrue: [ methodDefinition compiledMethod ] 
		ifFalse: [ nil ]