script executor
executableScriptHandler
	<gtExample>
	| handlerClass |
	handlerClass := GtDocumenterScriptExecutorHandler.
	self assert: (handlerClass handlesScript: self executableScriptTokens).
	^ handlerClass