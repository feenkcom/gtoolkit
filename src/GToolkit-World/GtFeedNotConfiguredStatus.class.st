Class {
	#name : #GtFeedNotConfiguredStatus,
	#superclass : #GtFeedStatus,
	#category : #'GToolkit-World-Feed'
}

{ #category : #accessing }
GtFeedNotConfiguredStatus class >> registryValue [
	^ #notConfigured
]

{ #category : #testing }
GtFeedNotConfiguredStatus >> isNotConfigured [
	^ true
]
