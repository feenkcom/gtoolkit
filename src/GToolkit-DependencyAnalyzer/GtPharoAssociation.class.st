Class {
	#name : #GtPharoAssociation,
	#superclass : #Object,
	#category : #'GToolkit-DependencyAnalyzer'
}

{ #category : #'instance creation' }
GtPharoAssociation >> from [
	^ self subclassResponsibility
]

{ #category : #'instance creation' }
GtPharoAssociation >> fromPackage [
	^ self from gtPackageScope
]

{ #category : #printing }
GtPharoAssociation >> gtDisplayOn: stream [
	self from gtDisplayOn: stream.
	stream nextPutAll: '->'.
	self to gtDisplayOn: stream
]

{ #category : #'instance creation' }
GtPharoAssociation >> to [
	^ self subclassResponsibility
]

{ #category : #'instance creation' }
GtPharoAssociation >> toPackage [
	^ self to gtPackageScope
]
