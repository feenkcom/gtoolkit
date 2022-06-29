Class {
	#name : #GtSpotterProcessorBuilder,
	#superclass : #Object,
	#instVars : [
		'processor'
	],
	#category : #'GToolkit-Spotter-Streaming-Searches'
}

{ #category : #private }
GtSpotterProcessorBuilder >> getProcessor [
	^ processor
]

{ #category : #decorating }
GtSpotterProcessorBuilder >> listProcessor [
	^ processor := GtSpotterCandidatesListProcessor new
]
