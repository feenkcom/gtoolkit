Class {
	#name : #GtSpotterSubstringFilterStream,
	#superclass : #Object,
	#traits : 'TAsyncStream',
	#classTraits : 'TAsyncStream classTrait',
	#instVars : [
		'scopeStream',
		'searchString',
		'caseSensitive',
		'itemStringBlock',
		'prefixMatches',
		'middleMatches',
		'currentMatchType',
		'currentOtherMatchStream'
	],
	#classVars : [
		'ExactMatch',
		'MiddleMatch',
		'NoMatch',
		'PrefixMatch'
	],
	#category : #'GToolkit-Spotter-Streaming-Streams'
}

{ #category : #'instance creation' }
GtSpotterSubstringFilterStream class >> forStream: aStream search: aSearchString [
	^ self new
		stream: aStream
		search: aSearchString
]

{ #category : #initialization }
GtSpotterSubstringFilterStream class >> initialize [
	ExactMatch := GtSpotterSubstringFilterExactMatch.
	PrefixMatch := GtSpotterSubstringFilterPrefixMatch.
	MiddleMatch := GtSpotterSubstringFilterMiddleMatch.
	NoMatch := GtSpotterSubstringFilterNoMatch
]

{ #category : #'api - configuration' }
GtSpotterSubstringFilterStream >> beCaseInsensitive [
	caseSensitive := false
]

{ #category : #'api - configuration' }
GtSpotterSubstringFilterStream >> beCaseSensitive [
	caseSensitive := true
]

{ #category : #'api - configuration' }
GtSpotterSubstringFilterStream >> caseSensitive: aBoolean [
	caseSensitive := aBoolean
]

{ #category : #initialization }
GtSpotterSubstringFilterStream >> initialize [
	super initialize.
	
	caseSensitive := false.
	itemStringBlock := [ :anObject | anObject printString ]
]

{ #category : #'api - configuration' }
GtSpotterSubstringFilterStream >> itemString: aBlock [
	itemStringBlock := aBlock
]

{ #category : #'private - filter' }
GtSpotterSubstringFilterStream >> itemStringOf: anObject [
	^ itemStringBlock value: anObject
]

{ #category : #'private - filter' }
GtSpotterSubstringFilterStream >> pollMiddleStream: anAsynchronousContext [
	self
		assert: [ currentMatchType = MiddleMatch ]
		description: [ 'Can only poll if matching middle type' ].

	^ (currentOtherMatchStream pollNext: anAsynchronousContext)
		ifReady: [ :aReadyPoll |
			aReadyPoll value isNone
				ifTrue: [
					currentMatchType := NoMatch.
					currentOtherMatchStream := AsyncEmptyStream new ].
			aReadyPoll ]
]

{ #category : #'api - stream' }
GtSpotterSubstringFilterStream >> pollNext: anAsynchronousContext [
	"Attempt to pull out the next value of this stream, registering the current task for wakeup if the value is not yet available, and returning None if the stream is exhausted.
	There are several possible return values, each indicating a distinct stream state:
	 - Poll::Pending means that this stream's next value is not ready yet. Implementations will ensure that the current task will be notified when the next value may be ready.
	 - Poll::Ready(Some(val)) means that the stream has successfully produced a value, val, and may produce further values on subsequent poll_next calls.
	 - Poll::Ready(None) means that the stream has terminated, and poll_next should not be invoked again."
	<return: #AsyncPoll>

	[ currentMatchType = ExactMatch
		ifTrue: [
			(self pollScopeStream: anAsynchronousContext)
				ifNotNil: [ :anAsyncPoll | ^ anAsyncPoll ] ]
		ifFalse: [
			currentMatchType = PrefixMatch
				ifTrue: [
					(self pollPrefixStream: anAsynchronousContext)
						ifNotNil: [ :anAsyncPoll | ^ anAsyncPoll ] ]
				ifFalse: [ 
					currentMatchType = MiddleMatch
						ifTrue: [
							(self pollMiddleStream: anAsynchronousContext)
								ifNotNil: [ :anAsyncPoll | ^ anAsyncPoll ] ]
						ifFalse: [ ^ AsyncPoll ready: AsyncOptionalValue none ]
				] ] ] repeat
]

{ #category : #'private - filter' }
GtSpotterSubstringFilterStream >> pollPrefixStream: anAsynchronousContext [
	self
		assert: [ currentMatchType = PrefixMatch ]
		description: [ 'Can only poll if matching prefix type' ].

	(currentOtherMatchStream pollNext: anAsynchronousContext)
		ifReady: [ :aReadyPoll |
			aReadyPoll value
				ifSome: [ ^ aReadyPoll ]
				ifNone: [ self tryToSwitchToMiddleMatches ] ]
		ifPending: [ :aPendingPoll | ^ aPendingPoll ].
	
	"we need another loop"
	^ nil
]

{ #category : #'private - filter' }
GtSpotterSubstringFilterStream >> pollScopeStream: anAsynchronousContext [
	(scopeStream pollNext: anAsynchronousContext)
		ifReady: [ :aReadyPoll |
			aReadyPoll value
				ifSome: [ :anObject |
					| aString aMatch |
	
					aString := self itemStringOf: anObject.
					aMatch := self searchSubstringIn: aString.

					"we found an exact match, we can return it directly"
					aMatch isExact
						ifTrue: [ ^ aReadyPoll ].
						
					aMatch isPrefix
						ifTrue: [ prefixMatches add: anObject ].
						
					aMatch isMiddle
						ifTrue: [ middleMatches add: anObject ] ]
				ifNone: [ self tryToSwitchToPrefixMatches ] ]
		ifPending: [ :aPendingPoll | ^ aPendingPoll ].

	^ nil
]

{ #category : #'api - stream copy' }
GtSpotterSubstringFilterStream >> postSimilarCopy [
	"Is called by similarCopy. self is a shallow copy, implementors should set the fields as necessary to complete the similar copy"
	
	self
		stream: scopeStream asyncSimilarCopy
		search: searchString
]

{ #category : #'private - filter' }
GtSpotterSubstringFilterStream >> searchSubstringIn: aString [
	<return: #GtSpotterSubstringFilterMatch>
	| anIndex |

	anIndex := aString 
		findString: searchString
		startingAt: 1 
		caseSensitive: caseSensitive.
		
	(anIndex = 1 and: [ aString size = searchString size ])
		ifTrue: [ ^ GtSpotterSubstringFilterExactMatch new index: anIndex ].
		
	anIndex = 1
		ifTrue: [ ^ GtSpotterSubstringFilterPrefixMatch new index: anIndex ].
		
	anIndex > 1
		ifTrue: [ ^ GtSpotterSubstringFilterMiddleMatch new index: anIndex ].
		
	^ GtSpotterSubstringFilterNoMatch new index: anIndex
]

{ #category : #initialization }
GtSpotterSubstringFilterStream >> stream: aStream search: aSearchString [
	scopeStream := aStream.
	searchString := aSearchString.
	prefixMatches := OrderedCollection new.
	middleMatches := OrderedCollection new.
	currentMatchType := ExactMatch.
	currentOtherMatchStream := AsyncEmptyStream new
]

{ #category : #'private - filter' }
GtSpotterSubstringFilterStream >> tryToSwitchToMiddleMatches [
	middleMatches
		ifEmpty: [
			"no interesting matches found, we are done"
			currentMatchType := NoMatch.
			currentOtherMatchStream := AsyncEmptyStream new ]
		ifNotEmpty: [ :theMiddleMatches |
			currentMatchType := MiddleMatch.
			currentOtherMatchStream := theMiddleMatches asAsyncStream ]
]

{ #category : #'private - filter' }
GtSpotterSubstringFilterStream >> tryToSwitchToPrefixMatches [
	prefixMatches
		ifEmpty: [ self tryToSwitchToMiddleMatches ]
		ifNotEmpty: [ :thePrefixMatches |
			currentMatchType := PrefixMatch.
			currentOtherMatchStream := thePrefixMatches asAsyncStream ]
]
