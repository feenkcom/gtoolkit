editing live document
insertScriptInTheMiddle
	<gtExample>
	<label: 'Text editor'>
	| editor twoCodes threeCodes |
	editor := self textEditorWithTwoCodeSnippets.
	twoCodes := GtDocumenterExamplesUtility codeSnippetsFromEditor: editor.
	self assert: (GtDocumenterExamplesUtility outsFromEditor: editor) size equals: 2.
	self assert: twoCodes size equals: 2.
	editor text insertString: self insertedScript at: self insertMiddlePosition.
	editor styleText.
	threeCodes := GtDocumenterExamplesUtility codeSnippetsFromEditor: editor.
	self assert: (GtDocumenterExamplesUtility outsFromEditor: editor) size equals: 3.
	self assert: threeCodes size equals: 3.
	self assert: twoCodes first == threeCodes first.
	self assert: (twoCodes second == threeCodes second) not.
	self assert: twoCodes second == threeCodes third.
	^ editor