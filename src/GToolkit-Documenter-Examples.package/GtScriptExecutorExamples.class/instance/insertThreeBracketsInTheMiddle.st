editing document
insertThreeBracketsInTheMiddle
	<gtExample>
	<label: 'Text editor'>
	| editor originalCodes newCodes |
	editor := self textEditorWithTwoCodeSnippets.
	originalCodes := self extractCodeSnippetsFromEditor: editor.
	self assert: (self outsFromEditor: editor) size equals: 2.
	self assert: originalCodes size equals: 2.
	editor text insertString: self insertedThreeBrackets at: 54.
	editor styleText.
	newCodes := self extractCodeSnippetsFromEditor: editor.
	self assert: (self outsFromEditor: editor) size equals: 2.
	self assert: newCodes size equals: 2.
	self assert: originalCodes first == newCodes first.
	self assert: originalCodes second == newCodes second.
	^ editor