instance creation
newOrExistingCodeSnippet
	<return: #GtCodeSnippetResult>
	self assert: [ self scriptIndex <= (self numberOfCodeSnippets + 1) ] description: [ 'A code snippet was skipped' ].
	(self numberOfCodeSnippets + 1) = self scriptIndex ifTrue: [
		self newCodeSnippetAtSameIndex ].
	^ self outs codeSnippetAt: self scriptIndex