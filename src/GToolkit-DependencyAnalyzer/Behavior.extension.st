Extension { #name : #Behavior }

{ #category : #'*GToolkit-DependencyAnalyzer' }
Behavior >> gtUsingMethods [
	^ self binding usingMethods collect: [ :eachMethod |
		GtPharoClassReference new 
			referencingMethod: eachMethod; 
			referencedClass: self ]
]
