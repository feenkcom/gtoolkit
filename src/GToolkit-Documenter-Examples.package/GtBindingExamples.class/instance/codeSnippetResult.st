code snippet result
codeSnippetResult
	<gtExample>
	<label: 'Default code snippet result bindings'>
	| bindings |
	bindings := GtCodeSnippetResult new.
	self assert: bindings result isNil.
"	self assert: bindings result key equals: GtDocumenterConstants resultVariableName.
	self assert: bindings result value isNil.
"	^ bindings