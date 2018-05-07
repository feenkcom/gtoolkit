default handler
defaultScriptHandler
	<gtExample>
	| handlerClass |
	handlerClass := GtDocumenterDefaultScriptHandler.
	self assert: (handlerClass handlesScript: self defaultScriptTokens).
	^ handlerClass