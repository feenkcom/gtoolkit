Class {
	#name : #GtCoderStencil,
	#superclass : #GtToolStencil,
	#category : #'GToolkit-World-Stencils'
}

{ #category : #'api - instantiation' }
GtCoderStencil >> create [
	^ GtInspector withToolOn: GtPackagesCoder new
]

{ #category : #accessing }
GtCoderStencil >> name [
	^ 'Coder'
]
