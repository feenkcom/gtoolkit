Class {
	#name : #GtTranscriptTextTaskAction,
	#superclass : #BlTask,
	#instVars : [
		'text',
		'editor'
	],
	#category : #'GToolkit-Transcript'
}

{ #category : #accessing }
GtTranscriptTextTaskAction >> editor [
	^ editor
]

{ #category : #accessing }
GtTranscriptTextTaskAction >> editor: anObject [
	editor := anObject
]

{ #category : #accessing }
GtTranscriptTextTaskAction >> text [
	^ text
]

{ #category : #accessing }
GtTranscriptTextTaskAction >> text: anObject [
	text := anObject
]
