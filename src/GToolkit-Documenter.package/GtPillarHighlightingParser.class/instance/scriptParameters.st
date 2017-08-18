parsers
scriptParameters
	^ parametersUntilNewline , newline optional ==> [ :array | array first ]
	==> [ :array |
		(({ array first } asOrderedCollection addAll: array last; yourself)
			collect: [ :each |
				('' join: each first) -> (each second ifNotNil: [:second | '' join: second ]) ]) ]