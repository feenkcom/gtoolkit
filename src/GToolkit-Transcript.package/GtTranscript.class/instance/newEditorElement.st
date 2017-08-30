ui
newEditorElement
	| transcriptElement |
	transcriptElement := GtTranscriptElement new
		transcript: self.
	transcriptElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	^ transcriptElement