Class {
	#name : #GtFeedEnabledStatus,
	#superclass : #GtFeedStatus,
	#category : #'GToolkit-World-Feed'
}

{ #category : #accessing }
GtFeedEnabledStatus class >> registryValue [
	^ #enabled
]

{ #category : #testing }
GtFeedEnabledStatus >> isEnabled [
	^ true
]
