Class {
	#name : #GtSceneDrillerTreeRowStencilBuilder,
	#superclass : #BrGlamorousSimpleTreeSelectableRowElementStencilBuilder,
	#instVars : [
		'whenHovered',
		'whenUnhovered'
	],
	#category : #'GToolkit-SceneDriller-UI'
}

{ #category : #'api - instantiation' }
GtSceneDrillerTreeRowStencilBuilder >> buildDefault [
	^ super buildDefault
		when: BlElementHoveredEvent do: self whenHovered;
		when: BlElementUnhoveredEvent do: self whenUnhovered
]

{ #category : #accessing }
GtSceneDrillerTreeRowStencilBuilder >> whenHovered [
	^ whenHovered
]

{ #category : #accessing }
GtSceneDrillerTreeRowStencilBuilder >> whenHovered: anObject [
	whenHovered := anObject
]

{ #category : #accessing }
GtSceneDrillerTreeRowStencilBuilder >> whenUnhovered [
	^ whenUnhovered
]

{ #category : #accessing }
GtSceneDrillerTreeRowStencilBuilder >> whenUnhovered: anObject [
	whenUnhovered := anObject
]
