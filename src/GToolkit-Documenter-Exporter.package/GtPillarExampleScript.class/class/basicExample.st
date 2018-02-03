as yet unclassified
basicExample
	<gtExample>
	<label: 'With basic parameters'>
	| parameters instance |
	parameters := SmallDictionary new
		at: 'example' put: 'GtPillarExampleScript class >> #basicExample';
		at: 'height' put: '400';
		at: 'expanded' put: 'true'; 
		at: 'noCode' put: 'false'; 
		at: 'show' put: 'gtPrintIn:';
		yourself.
	instance := self empty parameters: parameters; yourself.
	self assert: instance exampleCompiledMethod equals: self class >> #basicExample.
	self 
		assert: instance exampleSourceCode 
		equals: self class name asString, ' >> ', (self class >> #basicExample) sourceCode.
	self assert: instance text equals: instance exampleSourceCode.
	self assert: instance hasText not.
	self assert: instance language equals: PRSmalltalkScriptLanguage default.
	^ instance