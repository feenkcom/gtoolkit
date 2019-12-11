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
	| aStartPosition |

	self announcement wasExecuted ifTrue: [ ^ self ].
	self announcement beExecuted.
	
	aStartPosition := self editor text size + 1.
	
	self editor inserter
		atEnd;
		string: self string asString;
		insert.

	"we delete the possible attributes inherited from the previously existing text"
	self text
		clearAttributes: self text size - self string size + 1
		to: self text size
		if: [ :a | true ].
		
	(self text
		from: aStartPosition
		to: self text size)
			attributes: self attributes.
	
	self editor update: aStartPosition to: self text size.
	self editor invalidate: aStartPosition to: self text size.
	
]

{ #category : #accessing }
GtTranscriptInsertStringTaskAction >> string [
	^ string
]

{ #category : #accessing }
GtTranscriptInsertStringTaskAction >> string: anObject [
	string := anObject
]
