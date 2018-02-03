tests
testScriptExample
	| parameters |
	self
		parse:
			'[[[example=GtConnectorExamples>>#oneExampleMethod|height=400|expanded=true|noCode=true|show=gtLiveIn:]]]'
		rule: #script.
	parameters := SmallDictionary new
		at: 'example' put: 'GtConnectorExamples>>#oneExampleMethod';
		at: 'height' put: '400';
		at: 'expanded' put: 'true'; 
		at: 'noCode' put: 'true'; 
		at: 'show' put: 'gtLiveIn:';
		yourself.
	self 
		assert: result 
		equals: (GtPillarExampleScript content: '' parameters: parameters)