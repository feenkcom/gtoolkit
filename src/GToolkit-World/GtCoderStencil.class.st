Class {
	#name : #GtCoderStencil,
	#superclass : #GtToolStencil,
	#category : #'GToolkit-World'
}

{ #category : #'api - instantiation' }
GtCoderStencil >> create [
	^ GtInspector withToolOn: GtCoder new
]

{ #category : #accessing }
GtCoderStencil >> name [
	^ 'Coder'
]
