Class {
	#name : #GtSpotterSubstringFilter,
	#superclass : #Object,
	#traits : 'TGtSpotterFilter',
	#classTraits : 'TGtSpotterFilter classTrait',
	#instVars : [
		'caseSensitive'
	],
	#category : #'GToolkit-Spotter-Streaming-Filters'
}

{ #category : #evaluating }
GtSpotterSubstringFilter >> applyInScope: aStream context: aSpotterContext [
	^ GtSpotterSubstringFilterStream
		forStream: aStream
		search: aSpotterContext searchQuery
]
