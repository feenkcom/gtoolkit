private
previousCodeSnippetResult
	<return: #LiteralVariable or: nil>
	^ self outs ifNotNil: [ :anLiteralVariable | 
		anLiteralVariable value before: self ]