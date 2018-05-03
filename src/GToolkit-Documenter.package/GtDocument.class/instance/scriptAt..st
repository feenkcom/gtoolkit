accessing
scriptAt: anInteger 
	<return: #GtCodeSnippetResult>
	self assert: [ anInteger <= (outs size + 1) ] description: [ 'A code snippet was skipped' ].
	(outs size + 1) = anInteger ifTrue: [ | newScript |
		newScript := GtCodeSnippetResult new.
		newScript document: self ].
	^ outs scriptAt: anInteger