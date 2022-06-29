Class {
	#name : #GtSpotterNoFilter,
	#superclass : #Object,
	#traits : 'TGtSpotterFilter',
	#classTraits : 'TGtSpotterFilter classTrait',
	#category : #'GToolkit-Spotter-Streaming-Filters'
}

{ #category : #evaluating }
GtSpotterNoFilter >> applyInScope: aStream context: aSpotterContext [
	^ aStream
]
