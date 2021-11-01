Extension { #name : #Trait }

{ #category : #'*GToolkit-DependencyAnalyzer' }
Trait >> gtTraitUsers [
	^ self users collect: [ :aBehavior | GtPharoTraitUsage new baseBehavior: aBehavior; usedTrait: self ]
]
