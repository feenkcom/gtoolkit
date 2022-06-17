Class {
	#name : #GtTranscriptDeleteAllTaskAction,
	#superclass : #GtTranscriptTextTaskAction,
	#category : #'GToolkit-Transcript'
}

{ #category : #'api - running' }
GtTranscriptDeleteAllTaskAction >> run: aWaker [
	"We should only modify the editor from within the UI thread"
	
	self editor text deleteAll
]
