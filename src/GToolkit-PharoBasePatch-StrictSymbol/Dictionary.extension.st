Extension { #name : #Dictionary }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol' }
Dictionary >> sameContentAs: aDictionary [
	"Answer true if aDictionary has the same keys as the receiver, each with the same value,
	comparing strings and symbols in keys and values based on their content."

	| includesAll |
	self == aDictionary ifTrue: [ ^ true ].
	aDictionary isDictionary ifFalse: [ ^ false ].
	self size = aDictionary size ifFalse: [ ^ false ].
	includesAll := [ :aSource :aTarget |
		aSource associations
			allSatisfy: [ :each |
				(aTarget
					associationAt: each key
					ifAbsent: [ aTarget associations
							detect: [ :anAssociation | anAssociation key sameContentAs: each key ]
							ifNone: [ nil ] ])
					ifNil: [ false ]
					ifNotNil: [ :anAssociation | anAssociation value sameContentAs: each value ] ] ].
	^ (includesAll value: self value: aDictionary)
		and: [ includesAll value: aDictionary value: self ]
]
