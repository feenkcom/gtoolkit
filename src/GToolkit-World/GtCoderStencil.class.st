Class {
	#name : #GtCoderStencil,
	#superclass : #GtToolStencil,
	#category : #'GToolkit-World-Stencils'
}

{ #category : #'api - instantiation' }
GtCoderStencil >> create [
	^ GtPager createWrappedOn: GtCoder new
]

{ #category : #accessing }
GtCoderStencil >> name [
	^ 'Coder'
]
