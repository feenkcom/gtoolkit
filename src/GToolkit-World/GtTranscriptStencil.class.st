Class {
	#name : #GtTranscriptStencil,
	#superclass : #GtToolStencil,
	#category : #'GToolkit-World-Stencils'
}

{ #category : #'api - instantiation' }
GtTranscriptStencil >> create [
	^ GtTranscript default asElement
]

{ #category : #accessing }
GtTranscriptStencil >> name [
	^ 'Transcript'
]
