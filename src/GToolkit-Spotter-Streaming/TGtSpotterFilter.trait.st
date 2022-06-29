Trait {
	#name : #TGtSpotterFilter,
	#category : #'GToolkit-Spotter-Streaming-Filters'
}

{ #category : #evaluating }
TGtSpotterFilter >> applyInScope: aStream context: aSpotterContext [
	^ self explicitRequirement
]
