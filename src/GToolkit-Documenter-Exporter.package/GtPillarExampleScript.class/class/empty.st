as yet unclassified
empty
	<gtExample>
	<label: 'Unitialized instance without any parammeters'>
	| instance |
	instance := GtPillarExampleScript new.
	self assert: instance hasText not.
	self assert: instance text isNil.
	self assert: instance language equals: PRSmalltalkScriptLanguage default.
	^ instance