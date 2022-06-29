Class {
	#name : #GtSpotterCollectionSearch,
	#superclass : #GtSpotterSearch,
	#instVars : [
		'filterComputation',
		'itemsComputation'
	],
	#category : #'GToolkit-Spotter-Streaming-Searches'
}

{ #category : #converting }
GtSpotterCollectionSearch >> asStreamFor: aSpotterContext [
	<return: #TAsyncStream>
	| theScopeStream theSearchFilter |
	
	theScopeStream := (itemsComputation gtValue: aSpotterContext) asAsyncStream.
	theSearchFilter := filterComputation gtValue: aSpotterContext.
	
	^ theSearchFilter applyInScope: theScopeStream
]

{ #category : #accessing }
GtSpotterCollectionSearch >> filter: aFilterOrBlock [
	filterComputation := aFilterOrBlock
]

{ #category : #initialization }
GtSpotterCollectionSearch >> initialize [
	super initialize.
	
	filterComputation := [ :aSpotterContext |  ]
]

{ #category : #accessing }
GtSpotterCollectionSearch >> items: aBlock [
	itemsComputation := aBlock
]
