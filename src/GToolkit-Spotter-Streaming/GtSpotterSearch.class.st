Class {
	#name : #GtSpotterSearch,
	#superclass : #GtSpotterProtoSearch,
	#instVars : [
		'title',
		'priority'
	],
	#category : #'GToolkit-Spotter-Streaming-Searches'
}

{ #category : #converting }
GtSpotterSearch >> asStreamFor: aSpotterContext [
	<return: #TAsyncStream>
	
	^ self subclassResponsibility
]

{ #category : #accessing }
GtSpotterSearch >> priority [

	^ priority
]

{ #category : #accessing }
GtSpotterSearch >> priority: anObject [

	priority := anObject
]

{ #category : #accessing }
GtSpotterSearch >> title [

	^ title
]

{ #category : #accessing }
GtSpotterSearch >> title: anObject [

	title := anObject
]
