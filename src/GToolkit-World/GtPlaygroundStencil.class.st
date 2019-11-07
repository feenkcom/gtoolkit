Class {
	#name : #GtPlaygroundStencil,
	#superclass : #GtToolStencil,
	#category : #'GToolkit-World'
}

{ #category : #'api - instantiation' }
GtPlaygroundStencil >> create [
	^ GtInspector withToolOn: GtPlayBook newDefault
]

{ #category : #accessing }
GtPlaygroundStencil >> name [
	^ 'Playground'
]
