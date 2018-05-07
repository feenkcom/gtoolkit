accessing
exampleMethod
	<return: #CompiledMethod>
	^ exampleMethod ifNil: [ exampleMethod := Compiler evaluate: tokens exampleParameterValue ].