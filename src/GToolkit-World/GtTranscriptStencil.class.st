Class {
	#name : #GtTranscriptStencil,
	#superclass : #GtToolStencil,
	#category : #'GToolkit-World-Stencils'
}

{ #category : #converting }
GtTranscriptStencil >> asPreviewElement [
	^ GtTranscript default
]

{ #category : #'api - instantiation' }
GtTranscriptStencil >> create [
	^ (GtPager createWrappedOn: GtTranscript default) maximized.
]

{ #category : #accessing }
GtTranscriptStencil >> icon [
	^ BrGlamorousVectorIcons emphasizedInspect
]

{ #category : #accessing }
GtTranscriptStencil >> name [
	^ 'Transcript'
]
