accessing
exampleMethod
	<return: #CompiledMethod>
	^ exampleMethod ifNil: [ exampleMethod := Compiler evaluate: self exampleParameterValue ].