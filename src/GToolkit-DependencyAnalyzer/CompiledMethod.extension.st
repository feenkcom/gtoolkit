Extension { #name : #CompiledMethod }

{ #category : #'*GToolkit-DependencyAnalyzer' }
CompiledMethod >> gtReferencedBehaviors [
	"Return behaviors that are directly referenced by this method.
	Compared to #referencedClasses I do not count a value of the ClassVariable as a reference"

	^ self literalsEvenTheOnesInTheInnerBlocks
		select: [ :l | (l isKindOf: ClassVariable) not and: [ l value isBehavior ] ] 
		thenCollect: [:v | v value ].
]

{ #category : #'*GToolkit-DependencyAnalyzer' }
CompiledMethod >> gtReferencedClasses [
	"Return classes that are directly referenced by this method.
	Compared to #referencedClasses I do not count a value of the ClassVariable as a reference"

	^ self gtReferencedBehaviors select: [ :each | each isClass ]
]
