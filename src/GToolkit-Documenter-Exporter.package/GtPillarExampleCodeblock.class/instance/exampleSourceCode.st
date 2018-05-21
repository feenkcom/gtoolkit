accessing
exampleSourceCode
	| methodDefinition |
	methodDefinition := self exampleMethodDefinition.
	methodDefinition isDefined ifFalse: [ ^ methodDefinition printString ].
	^ String streamContents: [ :aStream | 
		aStream nextPutAll: methodDefinition methodClass name.
		aStream nextPutAll: ' >> '.
		aStream nextPutAll: methodDefinition sourceCode ].