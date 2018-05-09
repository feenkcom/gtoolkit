gt-examples
gtExampleHandler
	<gtExample>
	| handlerClass |
	handlerClass := GtPillarExampleCodeSnippetType.
	self assert: (handlerClass handlesScript: self gtExampleScriptTokens).
	^ handlerClass