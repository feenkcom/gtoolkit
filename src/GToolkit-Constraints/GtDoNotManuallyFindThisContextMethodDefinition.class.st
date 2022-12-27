Class {
	#name : #GtDoNotManuallyFindThisContextMethodDefinition,
	#superclass : #GtPharoConstraint,
	#category : #'GToolkit-Constraints-GToolkit-Constraints'
}

{ #category : #accessing }
GtDoNotManuallyFindThisContextMethodDefinition >> description [
	^ 'Check that thisContext is not used to access the method. We were using this pattern in Phlow.'
]

{ #category : #accessing }
GtDoNotManuallyFindThisContextMethodDefinition >> issues [
	^ (('`{:node | | found | found := false. node nodesDo: [:each | found := found or: [each isThisContextVariable]]. found} asRingDefinition' gtASTMatches result)
		filter: [ :eachMethod |
			BaselineOfGToolkit gtRlAllValidRPackages anySatisfy: [ :aPackage | 
				eachMethod package name = aPackage name ] ]) toArray wait 
	reject: [ :each | each selector = #testRemovesIrrelevantStackEntriesFromOnTop ]
]

{ #category : #accessing }
GtDoNotManuallyFindThisContextMethodDefinition >> name [
	^ 'ThisContext should not be used to access a method''s ring definition'
]
