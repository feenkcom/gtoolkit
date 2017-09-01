private
providerFor: anExampleOrExampleMethod
	| newProvider |
	newProvider := anExampleOrExampleMethod provider.
	^ providers at: newProvider class ifAbsentPut: [ newProvider ]