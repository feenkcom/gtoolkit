Class {
	#name : #GtPharoClassExtension,
	#superclass : #GtPharoAssociation,
	#instVars : [
		'extendingMethod'
	],
	#category : #'GToolkit-DependencyAnalyzer'
}

{ #category : #accessing }
GtPharoClassExtension >> extendedClass [
	^ self extendingMethod methodClass
]

{ #category : #accessing }
GtPharoClassExtension >> extendingMethod [
	^ extendingMethod
]

{ #category : #accessing }
GtPharoClassExtension >> extendingMethod: anObject [
	extendingMethod := anObject
]

{ #category : #'instance creation' }
GtPharoClassExtension >> from [
	^ self extendingMethod 
]

{ #category : #printing }
GtPharoClassExtension >> gtDisplayOn: stream [
	self extendingMethod package gtDisplayOn: stream.
	stream nextPutAll: ' extends '.
	self extendingMethod gtDisplayOn: stream
]

{ #category : #printing }
GtPharoClassExtension >> gtDisplayText [
	^  self extendingMethod package gtDisplayText glamorousMonospaceBackground,
		' extends ' asRopedText,
		self extendingMethod gtDisplayText glamorousMonospaceBackground
]

{ #category : #accessing }
GtPharoClassExtension >> gtSourceFor: aView [
	<gtView>
	^ aView explicit
		title: 'Source';
		priority: 10;
		stencil: [ (GtPharoMethodCoder new
			forMethod: self extendingMethod)
				asExpandedOnlyElement vFitContentLimited ]
]

{ #category : #'instance creation' }
GtPharoClassExtension >> to [
	^ self extendedClass  
]
