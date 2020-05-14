Class {
	#name : #GtPlaygroundStencil,
	#superclass : #GtToolStencil,
	#category : #'GToolkit-World-Stencils'
}

{ #category : #converting }
GtPlaygroundStencil >> asPreviewElement [
	^ GtPlayBook newDefault asElement
]

{ #category : #'api - instantiation' }
GtPlaygroundStencil >> create [
	^ GtPlayground create maximized
]

{ #category : #accessing }
GtPlaygroundStencil >> name [
	^ 'Playground'
]
