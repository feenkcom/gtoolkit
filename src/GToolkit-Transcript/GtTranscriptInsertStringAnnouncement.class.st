Class {
	#name : #GtTranscriptInsertStringAnnouncement,
	#superclass : #GtTranscriptAnnouncement,
	#instVars : [
		'text',
		'editor',
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

{ #category : #accessing }
GtTranscriptInsertStringAnnouncement >> editor [
	^ editor
]

{ #category : #accessing }
GtTranscriptInsertStringAnnouncement >> editor: anObject [
	editor := anObject
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

{ #category : #accessing }
GtTranscriptInsertStringAnnouncement >> text [
	^ text
]

{ #category : #accessing }
GtTranscriptInsertStringAnnouncement >> text: anObject [
	text := anObject
]

{ #category : #testing }
GtTranscriptInsertStringAnnouncement >> wasExecuted [
	^ executed
]
