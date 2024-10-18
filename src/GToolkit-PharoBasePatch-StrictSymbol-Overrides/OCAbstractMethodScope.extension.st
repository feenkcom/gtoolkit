Extension { #name : #OCAbstractMethodScope }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
OCAbstractMethodScope >> addCopyingTempToAllScopesUpToDefTemp: aVar [

	(self copiedVarNames stringContentIncludes: aVar name) ifFalse: [self addCopyingTemp: aVar].
	self = aVar scope ifTrue: [^ self].
	^ self outerScope addCopyingTempToAllScopesUpToDefTemp: aVar
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
OCAbstractMethodScope >> lookupVar: name declare: aBoolean [

	copiedVars at: name ifPresent: [:v | ^ v].
	tempVector at: name ifPresent: [:v | ^ v].
	tempVars at: name ifPresent: [:v | ^ v].
	(name sameContentAs:  self tempVectorName) ifTrue: [ ^ self tempVectorVar ].
	^self outerScope lookupVar: name declare: aBoolean
]
