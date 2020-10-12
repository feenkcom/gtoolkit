Class {
	#name : #GtCoderStencil,
	#superclass : #GtToolStencil,
	#instVars : [
		'coder'
	],
	#category : #'GToolkit-World-Stencils'
}

{ #category : #converting }
GtCoderStencil >> asPreviewElement [
	^ GtCoder new asElement
]

{ #category : #accessing }
GtCoderStencil >> coder [
	^ coder ifNil: [ coder := GtCoder new ]
]

{ #category : #accessing }
GtCoderStencil >> coder: aCoder [
	coder := aCoder
]

{ #category : #'api - instantiation' }
GtCoderStencil >> create [
	^ self coder createInPager maximized
]

{ #category : #accessing }
GtCoderStencil >> name [
	^ 'Coder'
]
