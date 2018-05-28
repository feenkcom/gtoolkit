instance creation
errorMessageText
	<return: #BrRopedText>

	self codeSnippet isMethodClassDefined ifFalse: [ 
		^ ('Example class (', self codeSnippet methodClassName , ') is not defined (yet).') asRopedText ].

	self codeSnippet isMethodDefined ifFalse: [ 
		^ ('Example method (', self codeSnippet methodSelectorName , ') is not defined (yet).') asRopedText ].

	^ ('Something wrong with ', self codeSnippet methodName) asRopedText