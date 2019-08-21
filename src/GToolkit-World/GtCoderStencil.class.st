Class {
	#name : #GtCoderStencil,
	#superclass : #GtToolStencil,
	#category : #'GToolkit-World'
}

{ #category : #'api - instantiation' }
GtCoderStencil >> create [
	^ GtInspector createOnPlayBook: (GtClassCoder new).
]

{ #category : #accessing }
GtCoderStencil >> name [
	^ 'Coder'
]
