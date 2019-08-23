Class {
	#name : #GtPlaygroundStencil,
	#superclass : #GtToolStencil,
	#category : #'GToolkit-World'
}

{ #category : #'api - instantiation' }
GtPlaygroundStencil >> create [
	^ GtInspector createOnPlayBook: GtPlayBook newDefault.
]

{ #category : #accessing }
GtPlaygroundStencil >> name [
	^ 'Playground'
]
