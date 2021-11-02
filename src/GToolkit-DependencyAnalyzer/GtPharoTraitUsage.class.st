Class {
	#name : #GtPharoTraitUsage,
	#superclass : #GtPharoAssociation,
	#instVars : [
		'trait',
		'baseBehavior'
	],
	#category : #'GToolkit-DependencyAnalyzer'
}

{ #category : #accessing }
GtPharoTraitUsage >> baseBehavior [
	^ baseBehavior
]

{ #category : #accessing }
GtPharoTraitUsage >> baseBehavior: aBehavior [
	baseBehavior := aBehavior
]

{ #category : #'instance creation' }
GtPharoTraitUsage >> from [
	^ self baseBehavior
]

{ #category : #accessing }
GtPharoTraitUsage >> gtDefinitionFor: aView [
	<gtView>
	^ aView explicit
		  title: 'Definition';
		  priority: 1;
		  stencil: [ (GtPharoSnippetCoder forSource: self baseBehavior definitionString) asExpandedOnlyElement vFitContentLimited ]
]

{ #category : #printing }
GtPharoTraitUsage >> gtDisplayOn: stream [
	self baseBehavior gtDisplayOn: stream.
	stream nextPutAll: ' uses '.
	self usedTrait gtDisplayOn: stream.
]

{ #category : #printing }
GtPharoTraitUsage >> gtDisplayText [	
	^  self baseBehavior name asRopedText glamorousMonospaceBackground,
		' uses ' asRopedText,
		self usedTrait name asRopedText glamorousMonospaceBackground
]

{ #category : #'instance creation' }
GtPharoTraitUsage >> to [
	^ self usedTrait
]

{ #category : #accessing }
GtPharoTraitUsage >> usedTrait [
	^ trait
]

{ #category : #accessing }
GtPharoTraitUsage >> usedTrait: aTrait [
	trait := aTrait
]
