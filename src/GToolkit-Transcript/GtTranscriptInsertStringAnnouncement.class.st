Class {
	#name : #GtTranscriptInsertStringAnnouncement,
	#superclass : #GtTranscriptAnnouncement,
	#instVars : [
		'string',
		'attributes',
		'executed'
	],
	#category : #'GToolkit-Transcript'
}

{ #category : #accessing }
GtTranscriptInsertStringAnnouncement >> attributes [
	^ attributes
]

{ #category : #accessing }
GtTranscriptInsertStringAnnouncement >> attributes: anObject [
	attributes := anObject
]

{ #category : #state }
GtTranscriptInsertStringAnnouncement >> beExecuted [
	executed := true
]

{ #category : #initialization }
GtTranscriptInsertStringAnnouncement >> initialize [
	super initialize.
	executed := false.
]

{ #category : #accessing }
GtTranscriptInsertStringAnnouncement >> string [
	^ string
]

{ #category : #accessing }
GtTranscriptInsertStringAnnouncement >> string: anObject [
	string := anObject
]

{ #category : #testing }
GtTranscriptInsertStringAnnouncement >> wasExecuted [
	^ executed
]
