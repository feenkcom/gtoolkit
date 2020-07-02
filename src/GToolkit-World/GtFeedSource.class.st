Class {
	#name : #GtFeedSource,
	#superclass : #Object,
	#instVars : [
		'url'
	],
	#category : #'GToolkit-World-Feed'
}

{ #category : #accessing }
GtFeedSource >> url [
	^ url
]

{ #category : #accessing }
GtFeedSource >> url: anObject [
	url := anObject
]
