Class {
	#name : #GtTranscriptInsertStringTaskAction,
	#superclass : #GtTranscriptTextTaskAction,
	#instVars : [
		'announcement',
		'string',
		'attributes'
	],
	#category : #'GToolkit-Transcript'
}

{ #category : #accessing }
GtTranscriptInsertStringTaskAction >> announcement [
	^ announcement
]

{ #category : #accessing }
GtTranscriptInsertStringTaskAction >> announcement: anObject [
	announcement := anObject
]

{ #category : #accessing }
GtTranscriptInsertStringTaskAction >> attributes [
	^ attributes
]

{ #category : #accessing }
GtTranscriptInsertStringTaskAction >> attributes: anObject [
	attributes := anObject
]

{ #category : #'api - running' }
GtTranscriptInsertStringTaskAction >> run [
	"We should only modify the editor from within the UI thread"
	self announcement wasExecuted
		ifTrue: [ ^ self ].
	self announcement beExecuted.

	self editor text append: (self string asRopedText attributes: self attributes)
]

{ #category : #accessing }
GtTranscriptInsertStringTaskAction >> string [
	^ string
]

{ #category : #accessing }
GtTranscriptInsertStringTaskAction >> string: anObject [
	string := anObject
]
