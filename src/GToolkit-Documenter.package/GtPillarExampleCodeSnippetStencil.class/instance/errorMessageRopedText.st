instance creation
errorMessageRopedText
	<return: #BrRopedText>
	self codeSnippet isMethodClassDefined ifFalse: [ 
		^ 'Example class is not defined (yet).' asRopedText ].
	self codeSnippet isMethodDefined ifFalse: [ 
		^ 'Example method is not defined (yet).' asRopedText ].
	^ ('Something wrong with ', self codeSnippet methodName) asRopedText