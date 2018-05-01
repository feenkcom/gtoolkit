bindings
addVariableBinding: anAssociation 
	self assert: [ anAssociation notNil ].
	self assert: [ anAssociation key isSymbol ].
	bindings addVariableBinding: anAssociation 