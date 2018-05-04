editing document
insertScriptInTheMiddle
	<gtExample>
	<label: 'Text editor'>
	| editor twoCodes threeCodes |
	editor := self textEditorWithTwoCodeSnippets.
	twoCodes := self extractCodeSnippetsFromEditor: editor.
	self assert: (self outsFromEditor: editor) size equals: 2.
	self assert: twoCodes size equals: 2.
	editor text insertString: self insertedScript at: 54.
	editor styleText.
	threeCodes := self extractCodeSnippetsFromEditor: editor.
	self assert: (self outsFromEditor: editor) size equals: 3.
	self assert: threeCodes size equals: 3.
	self assert: twoCodes first == threeCodes first.
	self assert: (twoCodes second == threeCodes second) not.
	self assert: twoCodes second == threeCodes third.
	^ editor