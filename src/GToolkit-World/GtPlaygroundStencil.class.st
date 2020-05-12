Class {
	#name : #GtPlaygroundStencil,
	#superclass : #GtToolStencil,
	#category : #'GToolkit-World-Stencils'
}

{ #category : #'api - instantiation' }
GtPlaygroundStencil >> create [
	^ GtPlayground create
]

{ #category : #accessing }
GtPlaygroundStencil >> name [
	^ 'Playground'
]
