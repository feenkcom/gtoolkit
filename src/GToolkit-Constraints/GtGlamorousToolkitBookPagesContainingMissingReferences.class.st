Class {
	#name : #GtGlamorousToolkitBookPagesContainingMissingReferences,
	#superclass : #GtPharoConstraint,
	#category : #'GToolkit-Constraints'
}

{ #category : #accessing }
GtGlamorousToolkitBookPagesContainingMissingReferences >> description [
	^ 'All references to methods and classes from the Glamorous Toolkit Book should be present in the image'
]

{ #category : #accessing }
GtGlamorousToolkitBookPagesContainingMissingReferences >> issues [
	| results lepiterKnowledgebases |
	results := LePageValidatorMissingReferencesGroup new.
	lepiterKnowledgebases := self knowledgebasesToAnalyse.
	lepiterKnowledgebases do: [ :aKnowledgebase |  
		aKnowledgebase pagesDo: [ :aPage |
			| visitor missingCodeReferences |
			visitor := LeMissingCodeReferencesModelVisitor new.
			
			missingCodeReferences := visitor missingReferencesInPage: aPage.
			missingCodeReferences isNotEmpty ifTrue: [ 
				results addMissingReferences: missingCodeReferences ] ] ].
	^ results
]

{ #category : #accessing }
GtGlamorousToolkitBookPagesContainingMissingReferences >> knowledgebasesToAnalyse [
	^ { LeDatabasesRegistry defaultLogicalDatabase databaseNamed: 'Glamorous Toolkit Book' }
]

{ #category : #accessing }
GtGlamorousToolkitBookPagesContainingMissingReferences >> name [
	^ 'Glamorous Toolkit Book Pages Containing Missing References'
]

{ #category : #initialization }
GtGlamorousToolkitBookPagesContainingMissingReferences >> status [
	^ GtNeutralConstraintStatus new
]
