gt-examples
gtExampleHandler
	<gtExample>
	| handlerClass |
	handlerClass := GtDocumenterExampleScriptHandler.
	self assert: (handlerClass handlesScript: self gtExampleScriptTokens).
	^ handlerClass