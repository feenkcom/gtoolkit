Class {
	#name : #GtCoderStencil,
	#superclass : #GtToolStencil,
	#category : #'GToolkit-World-Stencils'
}

{ #category : #converting }
GtCoderStencil >> asPreviewElement [
	^ GtPhlowCoderView new asElement
]

{ #category : #'api - instantiation' }
GtCoderStencil >> create [
	^ GtPhlowCoderView new asElement createInPager maximized.
]

{ #category : #accessing }
GtCoderStencil >> icon [
	^ BrGlamorousVectorIcons emphasizedBrowse
]

{ #category : #accessing }
GtCoderStencil >> name [
	^ 'Coder'
]
