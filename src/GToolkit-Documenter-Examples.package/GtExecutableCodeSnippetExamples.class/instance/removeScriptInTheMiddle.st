editing live document
removeScriptInTheMiddle
	<gtExample>
	<label: 'Remove a script in the middle'>
	| editor twoCodes threeCodes |
	editor := self insertScriptInTheMiddle.
	threeCodes := GtDocumenterExamplesUtility codeSnippetsFromEditor: editor.
	self assert: (GtDocumenterExamplesUtility outsFromEditor: editor) size equals: 3.
	self assert: threeCodes size equals: 3.
	editor text
		delete: self insertMiddlePosition
		to: self insertedScript size + self insertMiddlePosition.
	editor styleText.
	twoCodes := GtDocumenterExamplesUtility codeSnippetsFromEditor: editor.
	self assert: (GtDocumenterExamplesUtility outsFromEditor: editor) size equals: 2.
	self assert: twoCodes size equals: 2.
	self assert: twoCodes first == threeCodes first.
	self assert: (twoCodes second == threeCodes second) not.
	self assert: twoCodes second == threeCodes third.
	^ editor