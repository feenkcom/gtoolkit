accessing-delegated
label
	^ super label ifEmpty: [ self tokens epiceaParameterStringValue ]