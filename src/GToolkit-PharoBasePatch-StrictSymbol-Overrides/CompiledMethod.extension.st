Extension { #name : #CompiledMethod }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
CompiledMethod >> sameAsMCDefinition: anMCMethodDefinition [

	^ anMCMethodDefinition selector = self selector and: [ 
		 (anMCMethodDefinition className sameContentAs:  self className) and: [ 
			  anMCMethodDefinition classIsMeta = self isClassSide and: [ 
					  anMCMethodDefinition category = self protocol and: [ 
						  anMCMethodDefinition source = self sourceCode ] ] ] ]
]
