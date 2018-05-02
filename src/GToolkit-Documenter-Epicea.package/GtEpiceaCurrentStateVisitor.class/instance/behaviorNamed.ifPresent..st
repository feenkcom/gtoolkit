private
behaviorNamed: aSymbol ifPresent: presentBlock

	^ (theEnvironment classOrTraitNamed: aSymbol) 
		ifNil: [ self ]
		ifNotNil: presentBlock