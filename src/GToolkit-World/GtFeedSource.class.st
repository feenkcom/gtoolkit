Class {
	#name : #GtFeedSource,
	#superclass : #Object,
	#instVars : [
		'url'
	],
	#category : #'GToolkit-World-Feed'
}

{ #category : #printing }
GtFeedSource >> gtDisplayOn: aStream [
	super gtDisplayOn: aStream.
	aStream 
		nextPutAll: ' (';
		nextPutAll: self url;
		nextPutAll: ')'
]

{ #category : #accessing }
GtFeedSource >> url [
	^ url
]

{ #category : #accessing }
GtFeedSource >> url: anObject [
	url := anObject
]
