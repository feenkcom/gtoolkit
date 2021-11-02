Class {
	#name : #GtPharoClassReference,
	#superclass : #GtPharoAssociation,
	#instVars : [
		'referencingMethod',
		'referencedClass'
	],
	#category : #'GToolkit-DependencyAnalyzer'
}

{ #category : #accessing }
GtPharoClassReference >> from [
	^ self referencingMethod 
]

{ #category : #printing }
GtPharoClassReference >> gtDisplayOn: stream [
	self referencingMethod gtDisplayOn: stream.
	stream nextPutAll: ' references '.
	self referencedClass gtDisplayOn: stream
]

{ #category : #printing }
GtPharoClassReference >> gtDisplayText [
	^  self referencingMethod gtDisplayText glamorousMonospaceBackground,
		' references ' asRopedText,
		self referencedClass gtDisplayText glamorousMonospaceBackground
]

{ #category : #accessing }
GtPharoClassReference >> gtSourceFor: aView [
	<gtView>
	^ aView explicit
		title: 'Source';
		priority: 10;
		stencil: [ (GtPharoMethodCoder new
			forMethod: self referencingMethod;
			highlighter: (GtPharoVariableReferenceHighlighter forVariableName: self referencedClass name))
				asExpandedOnlyElement vFitContentLimited ]
]

{ #category : #accessing }
GtPharoClassReference >> referencedClass [
	^ referencedClass
]

{ #category : #accessing }
GtPharoClassReference >> referencedClass: anObject [
	referencedClass := anObject
]

{ #category : #accessing }
GtPharoClassReference >> referencingMethod [
	^ referencingMethod
]

{ #category : #accessing }
GtPharoClassReference >> referencingMethod: anObject [
	referencingMethod := anObject
]

{ #category : #accessing }
GtPharoClassReference >> to [
	^ self referencedClass 
]
