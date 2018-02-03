accessing
text
	"Return script body. For examples it should be nil by default. 
	For that reasone we return an example source code"
	<return: #String or: nil>
	^ super text isEmptyOrNil 
		ifTrue: [ self exampleSourceCode ]
		ifFalse: [ super text ]