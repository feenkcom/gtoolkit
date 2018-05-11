editing live document
insertThreeBracketsInTheMiddle
	<gtExample>
	<label: 'Text editor'>
	| editor originalCodes newCodes |
	editor := self textEditorWithTwoCodeSnippets.
	originalCodes := GtDocumenterExamplesUtility codeSnippetsFromEditor: editor.
	self assert: (GtDocumenterExamplesUtility outsFromEditor: editor) size equals: 2.
	self assert: originalCodes size equals: 2.
	editor text insertString: self insertedThreeBrackets at: self insertMiddlePosition.
	editor styleText.
	newCodes := GtDocumenterExamplesUtility codeSnippetsFromEditor: editor.
	self assert: (GtDocumenterExamplesUtility outsFromEditor: editor) size equals: 2.
	self assert: newCodes size equals: 2.
	self assert: originalCodes first == newCodes first.
	self assert: originalCodes second == newCodes second.
	^ editor