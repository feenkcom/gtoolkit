script executor
executableScriptHandler2
	<gtExample>
	| handlerClass |
	handlerClass := self scriptHandler handlerForScript: self executableScriptTokens.
	self assert: handlerClass equals: GtDocumenterScriptExecutorHandler.
	^ handlerClass