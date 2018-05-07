gt-examples
gtExampleHandler2
	<gtExample>
	| handlerClass |
	handlerClass := self scriptHandler handlerForScript: self gtExampleScriptTokens.
	self assert: handlerClass equals: GtDocumenterExampleScriptHandler.
	^ handlerClass