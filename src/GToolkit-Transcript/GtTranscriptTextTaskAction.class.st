Class {
	#name : #GtTranscriptTextTaskAction,
	#superclass : #BlTask,
	#instVars : [
		'editor'
	],
	#category : #'GToolkit-Transcript'
}

{ #category : #testing }
GtTranscriptTextTaskAction class >> isAbstract [
	^ self name = #GtTranscriptTextTaskAction 
]

{ #category : #accessing }
GtTranscriptTextTaskAction >> editor [
	^ editor
]

{ #category : #accessing }
GtTranscriptTextTaskAction >> editor: anObject [
	editor := anObject
]
