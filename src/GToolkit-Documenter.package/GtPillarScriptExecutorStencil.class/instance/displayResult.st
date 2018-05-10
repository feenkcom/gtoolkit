actions
displayResult
	self codeSnippet hasResult ifFalse: [ ^ self ].
	self editor fireEvent: (
		GLMBlocObjectToSelect new 
			toSelect: self codeSnippet value)