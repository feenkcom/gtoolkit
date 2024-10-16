Extension { #name : #OCAbstractMethodScope }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
OCAbstractMethodScope >> lookupVar: name declare: aBoolean [

	copiedVars at: name ifPresent: [:v | ^ v].
	tempVector at: name ifPresent: [:v | ^ v].
	tempVars at: name ifPresent: [:v | ^ v].
	(name sameContentAs:  self tempVectorName) ifTrue: [ ^ self tempVectorVar ].
	^self outerScope lookupVar: name declare: aBoolean
]
