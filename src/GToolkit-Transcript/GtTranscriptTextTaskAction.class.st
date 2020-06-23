Class {
	#name : #GtTranscriptTextTaskAction,
	#superclass : #BlTask,
	#instVars : [
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
