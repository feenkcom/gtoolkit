Extension { #name : #TonelParser }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
TonelParser >> newClassDefinitionFrom: anArray [
	| metadata |

	metadata := anArray sixth.
	^ MCClassDefinition
		name: (metadata at: #name)
		superclassName: (metadata at: #superclass)
		traitComposition: (metadata at: #traits ifAbsent: [ '{}' ])
		classTraitComposition: (metadata at: #classTraits ifAbsent: [ '{}' ])
		category: (metadata at: #category)
		instVarNames: (metadata at: #instVars ifAbsent: [ #() ])
		classVarNames: (metadata at: #classVars ifAbsent: [ #() ])
		poolDictionaryNames: (metadata at: #pools ifAbsent: [ #() ])
		classInstVarNames: (metadata at: #classInstVars ifAbsent: [ #() ])
		type: (metadata at: #type ifAbsent: [ #normal ]) asSymbol
		comment: (anArray second ifNil: [ '' ])
		commentStamp: nil
]
