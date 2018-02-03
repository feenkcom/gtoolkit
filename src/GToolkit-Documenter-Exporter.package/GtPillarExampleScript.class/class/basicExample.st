as yet unclassified
basicExample
	<gtExample>
	| parameters instance |
	parameters := SmallDictionary new
		at: 'example' put: 'GtPillarExampleScript class >> #basicExample';
		at: 'height' put: '400';
		at: 'expanded' put: 'true'; 
		at: 'noCode' put: 'true'; 
		at: 'show' put: 'gtLiveIn:';
		yourself.
	instance := GtPillarExampleScript content: '' parameters: parameters.
	self assert: (instance exampleSourceCode endsWith: (GtPillarExampleScript class >> #basicExample) sourceCode).
	self assert: instance hasText not.
	^ instance