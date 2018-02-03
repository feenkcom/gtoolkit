accessing
exampleSourceCode
	| compiledMethod |
	compiledMethod := self exampleCompiledMethod.
	compiledMethod ifNil: [ ^ nil ].
	^ String streamContents: [ :aStream | 
		aStream nextPutAll: compiledMethod methodClass name.
		aStream nextPutAll: ' >> '.
		aStream nextPutAll: compiledMethod sourceCode ].