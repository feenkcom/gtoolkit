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
	^ GtCoder new createInPager maximized.
]

{ #category : #accessing }
GtCoderStencil >> name [
	^ 'Coder'
]
