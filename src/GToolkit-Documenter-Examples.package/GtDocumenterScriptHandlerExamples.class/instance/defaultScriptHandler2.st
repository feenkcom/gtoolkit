default handler
defaultScriptHandler2
	<gtExample>
	| handlerClass |
	handlerClass := self scriptHandler handlerForScript: self defaultScriptTokens.
	self assert: handlerClass equals: GtDocumenterDefaultScriptHandler.
	^ handlerClass