Class {
	#name : #GtTranscriptInsertStringCommand,
	#superclass : #Object,
	#instVars : [
		'string',
		'attributes',
		'text',
		'editor'
	],
	#category : #'GToolkit-Transcript'
}

{ #category : #accessing }
GtTranscriptInsertStringCommand >> attributes [
	^ attributes
]

{ #category : #accessing }
GtTranscriptInsertStringCommand >> attributes: anObject [
	attributes := anObject
]

{ #category : #accessing }
GtTranscriptInsertStringCommand >> editor [
	^ editor
]

{ #category : #accessing }
GtTranscriptInsertStringCommand >> editor: anObject [
	editor := anObject
]

{ #category : #execution }
GtTranscriptInsertStringCommand >> execute [
	"We should only modify the editor from within the UI thread"
	| aStartPosition |

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
GtTranscriptInsertStringCommand >> string [
	^ string
]

{ #category : #accessing }
GtTranscriptInsertStringCommand >> string: anObject [
	string := anObject
]

{ #category : #accessing }
GtTranscriptInsertStringCommand >> text [
	^ text
]

{ #category : #accessing }
GtTranscriptInsertStringCommand >> text: anObject [
	text := anObject
]
