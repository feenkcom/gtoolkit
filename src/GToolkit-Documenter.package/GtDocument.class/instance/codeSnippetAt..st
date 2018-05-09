accessing
codeSnippetAt: anInteger 
	<return: #GtCodeSnippetResult>
	self flag: 'remove it'.
	self assert: [ anInteger <= (codeSnippets size + 1) ] description: [ 'A code snippet was skipped' ].
	(codeSnippets size + 1) = anInteger ifTrue: [ | newScript |
		newScript := GtCodeSnippetResult new.
		newScript document: self ].
	^ codeSnippets codeSnippetAt: anInteger