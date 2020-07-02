Class {
	#name : #GtFeedStatus,
	#superclass : #Object,
	#category : #'GToolkit-World-Feed'
}

{ #category : #accessing }
GtFeedStatus class >> registryValue [
	self subclassResponsibility
]

{ #category : #testing }
GtFeedStatus >> isEnabled [
	^ false
]

{ #category : #testing }
GtFeedStatus >> isNotConfigured [
	^ false
]

{ #category : #accessing }
GtFeedStatus >> registryValue [
	^ self class registryValue
]
