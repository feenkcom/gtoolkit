*GToolkit-Documenter-Examples
withSourceCodeAndPrintInFigure
	<gtExample>
	<label: 'Output with a source code gtPrinIn: Figure output'>
	| parameters instance |
	parameters := SmallDictionary new
		at: 'example' put: 'GtPillarExampleScript class >> #withSourceCodeAndPrintInFigure';
		at: 'height' put: '400';
		at: 'expanded' put: 'true'; 
		at: 'noCode' put: 'false'; 
		at: 'show' put: 'gtPrintIn:';
		yourself.
	instance := self empty parameters: parameters; yourself.
	self assert: instance exampleCompiledMethod equals: self class >> #withSourceCodeAndPrintInFigure.
	self 
		assert: instance exampleSourceCode 
		equals: self class name asString, ' >> ', (self class >> #withSourceCodeAndPrintInFigure) sourceCode.
	self assert: instance text equals: instance exampleSourceCode.
	self assert: instance hasText not.
	self assert: instance language equals: PRSmalltalkScriptLanguage default.
	self assert: instance noCode not.
	^ instance