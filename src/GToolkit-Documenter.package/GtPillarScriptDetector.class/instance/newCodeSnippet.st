instance creation
newCodeSnippet
	<return: #GtCodeSnippetResult>
	self assert: [ self scriptIndex <= (self numberOfCodeSnippets + 1) ] description: [ 'A code snippet was skipped' ].
	(self numberOfCodeSnippets + 1) = self scriptIndex ifTrue: [ | newScript |
		newScript := GtCodeSnippetResult new.
		newScript index: self scriptIndex.
		newScript sourceCode: self sourceCode.
		newScript document: self document ].
	^ self outs scriptAt: self scriptIndex