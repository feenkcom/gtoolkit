accessing
exampleClass
	^ exampleClass ifNil: [ exampleClass := self defaultExampleClass ]