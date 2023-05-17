Class {
	#name : #GtGlamorousToolkitBookPagesContainingMissingReferences,
	#superclass : #GtPharoConstraint,
	#category : #'GToolkit-Constraints'
}

{ #category : #analysing }
GtGlamorousToolkitBookPagesContainingMissingReferences >> collectAllowedMissingCodeReferencesInKnowledgeBase: aKnowledgebase into: aResultsGroup [ 
	^ self 
		collectMissingCodeReferencesInKnowledgeBase: aKnowledgebase 
		into: aResultsGroup 
		matchingPage: [ :aPage |
			(self shouldIgnoreMissingCodeReferencesInPage: aPage) not ]
]

{ #category : #analysing }
GtGlamorousToolkitBookPagesContainingMissingReferences >> collectIgnoredMissingCodeReferencesInKnowledgeBase: aKnowledgebase into: aResultsGroup [
	^ self 
		collectMissingCodeReferencesInKnowledgeBase: aKnowledgebase 
		into: aResultsGroup 
		matchingPage: [ :aPage |
			self shouldIgnoreMissingCodeReferencesInPage: aPage ]
]

{ #category : #analysing }
GtGlamorousToolkitBookPagesContainingMissingReferences >> collectMissingCodeReferencesInKnowledgeBase: aKnowledgebase into: aResultsGroup matchingPage: aPageConditionBlock [
	aKnowledgebase pagesDo: [ :aPage |
		| missingCodeReferences |

		missingCodeReferences := self findMissingReferencesInPage: aPage.
		missingCodeReferences isNotEmpty ifTrue: [
			(aPageConditionBlock value: aPage)
				ifTrue: [ 
					aResultsGroup addMissingReferences: missingCodeReferences ] ] ]
]

{ #category : #accessing }
GtGlamorousToolkitBookPagesContainingMissingReferences >> description [
	^ 'All references to methods and classes from the Glamorous Toolkit Book should be present in the image'
]

{ #category : #visiting }
GtGlamorousToolkitBookPagesContainingMissingReferences >> findMissingReferencesInPage: aPage [
	| visitor missingCodeReferences |
	visitor := LeMissingCodeReferencesModelVisitor new.
			
	missingCodeReferences := visitor missingReferencesInPage: aPage.
	^ missingCodeReferences
]

{ #category : #accessing }
GtGlamorousToolkitBookPagesContainingMissingReferences >> gtIgnoredItemsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Ignored issues';
		priority: 5;
		items: [ self ignoredIssues ];
		column: 'Index'
			text: [ :eachItem :eachIndex | eachIndex asRopedText foreground: Color gray ]
			width: 45;
		column: 'Item' text: [ :eachItem | eachItem gtDisplayText ];
		actionUpdateButton.
]

{ #category : #accessing }
GtGlamorousToolkitBookPagesContainingMissingReferences >> ignoredIssues [
	| results |
	results := LePageValidatorMissingReferencesGroup new.
	self knowledgebasesToAnalyse do: [ :aKnowledgebase |  
		self 
			collectIgnoredMissingCodeReferencesInKnowledgeBase: aKnowledgebase 
			into: results  ].
	^ results
]

{ #category : #accessing }
GtGlamorousToolkitBookPagesContainingMissingReferences >> issues [
	| results |
	results := LePageValidatorMissingReferencesGroup new.
	self knowledgebasesToAnalyse do: [ :aKnowledgebase |  
		self 
			collectAllowedMissingCodeReferencesInKnowledgeBase: aKnowledgebase 
			into: results ].
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

{ #category : #accessing }
GtGlamorousToolkitBookPagesContainingMissingReferences >> nameOfPageWithAllowedFailures [
	^ 'Pages Containing Missing References - Allowed Failures'
]

{ #category : #testing }
GtGlamorousToolkitBookPagesContainingMissingReferences >> shouldIgnoreMissingCodeReferencesInPage: aPage [
	^ aPage allOutgoingTextualLinks
		anySatisfy: [ :aLink | 
			aLink targetPageTitle = self nameOfPageWithAllowedFailures ]
]
