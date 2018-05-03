code snippet result
queryCodeSnippetResult
	<gtExample>
	<label: 'Set code snippet bindings'>
	| bindings result |
	bindings := self setCodeSnippetResult.
	result := bindings bindingOf: self variableOneName.
	self assert: result notNil.
	self assert: result key equals: self variableOneName.
	self assert: result value equals: 42.
	^ result