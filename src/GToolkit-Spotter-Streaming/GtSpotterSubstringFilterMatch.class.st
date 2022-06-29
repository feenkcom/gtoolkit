Class {
	#name : #GtSpotterSubstringFilterMatch,
	#superclass : #Object,
	#instVars : [
		'index'
	],
	#category : #'GToolkit-Spotter-Streaming-Streams - Utilities'
}

{ #category : #accessing }
GtSpotterSubstringFilterMatch >> index [

	^ index
]

{ #category : #accessing }
GtSpotterSubstringFilterMatch >> index: anObject [

	index := anObject
]

{ #category : #testing }
GtSpotterSubstringFilterMatch >> isExact [
	^ false
]

{ #category : #testing }
GtSpotterSubstringFilterMatch >> isMiddle [
	^ false
]

{ #category : #testing }
GtSpotterSubstringFilterMatch >> isPrefix [
	^ false
]
