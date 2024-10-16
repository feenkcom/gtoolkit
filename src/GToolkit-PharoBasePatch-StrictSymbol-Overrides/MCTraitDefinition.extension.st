Extension { #name : #MCTraitDefinition }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
MCTraitDefinition >> = aDefinition [
	self flag: #traits. "Ugly we harcoded the super superclass method.  We will have to refactor the definition hierarchy"
	
	^ (aDefinition isKindOf: MCDefinition)
		and: [(self isRevisionOf: aDefinition)
		and: [self traitCompositionString = aDefinition traitCompositionString
		and: [self classTraitCompositionString = aDefinition classTraitCompositionString
		and: [(category sameContentAs: aDefinition category)
		and: [self slotDefinitionString = aDefinition slotDefinitionString
		and: [self classInstVarNames  = aDefinition classInstVarNames  
		and: [comment = aDefinition comment]]]]]]]
]
