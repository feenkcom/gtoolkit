Class {
	#name : #GtFeedStatus,
	#superclass : #Object,
	#traits : 'TGtInteractiveStatusInstantiation',
	#classTraits : 'TGtInteractiveStatusInstantiation classTrait',
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
