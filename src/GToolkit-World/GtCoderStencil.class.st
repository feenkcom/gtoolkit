Class {
	#name : #GtCoderStencil,
	#superclass : #GtToolStencil,
	#category : #'GToolkit-World-Stencils'
}

{ #category : #converting }
GtCoderStencil >> asPreviewElement [
	^ GtCoder new asElement
]

{ #category : #'api - instantiation' }
GtCoderStencil >> create [
	^ (GtPager createWrappedOn: GtCoder new) maximized.
]

{ #category : #accessing }
GtCoderStencil >> name [
	^ 'Coder'
]
