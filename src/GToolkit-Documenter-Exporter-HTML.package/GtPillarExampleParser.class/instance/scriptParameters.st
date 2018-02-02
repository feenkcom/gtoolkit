accessing
scriptParameters
	^ parametersUntilNewline , newline optional ==> [ :array | array first ]
		==> [ :array | self parametersFrom: array ]