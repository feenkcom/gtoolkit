*GToolkit-Documenter-Examples
empty
	<gtExample>
	<label: 'Unitialized instance without any parammeters'>
	| instance |
	instance := GtPillarExampleScript new.
	self assert: instance hasText not.
	self assert: instance text equals: ''.
	self assert: instance language equals: PRSmalltalkScriptLanguage default.
	self assert: instance noCode not.
	^ instance