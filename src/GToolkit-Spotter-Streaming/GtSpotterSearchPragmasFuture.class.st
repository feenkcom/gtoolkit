"
I am a {{gtClass:TAsyncFuture}} which resolves to a collection of {{gtExample:GtSpotterSearchPragmasFuture class>>#pragmaSymbol|noCode|previewShow=#gtSymbolFor:|label=#printString}} pragmas starting from a class of the origin object all the way up to {{gtClass:Object}}. The returned list is un-ordered.

"
Class {
	#name : #GtSpotterSearchPragmasFuture,
	#superclass : #Object,
	#traits : 'TAsyncFuture',
	#classTraits : 'TAsyncFuture classTrait',
	#instVars : [
		'origin'
	],
	#category : #'GToolkit-Spotter-Streaming-Streams'
}

{ #category : #'instance creation' }
GtSpotterSearchPragmasFuture class >> forOriginObject: anObject [
	^ self new forOriginObject: anObject
]

{ #category : #accessing }
GtSpotterSearchPragmasFuture class >> pragmaSymbol [
	<gtExample>

	^ #gtSearch
]

{ #category : #initialization }
GtSpotterSearchPragmasFuture >> forOriginObject: anObject [
	origin := anObject
]

{ #category : #'api - future' }
GtSpotterSearchPragmasFuture >> poll: anAsynchronousContext [
	<return: #AsyncPoll>

	^ AsyncPoll ready: (Pragma allNamed: self class pragmaSymbol from: origin class to: Object) asAsyncStream
]
