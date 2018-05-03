bindings
setPlaygroundBindings
	<gtExample>
	<label: 'Set variable one'>
	| bindings result |
	bindings := self playgroundBindings.
	bindings addNamed: self variableOneName value: 42.
	result := bindings
		bindingOf: self variableOneName.
	self assert: result notNil.
	self assert: result value equals: 42.
	self assert: result key equals: self variableOneName.
	^ bindings