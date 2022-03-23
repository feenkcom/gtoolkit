Class {
	#name : #GtEpiceaStencil,
	#superclass : #GtToolStencil,
	#category : #'GToolkit-World-Stencils'
}

{ #category : #accessing }
GtEpiceaStencil >> asPreviewElement [
	^ GtEpiceaElement new asElement
]

{ #category : #accessing }
GtEpiceaStencil >> create [
	^ GtEpiceaElement new createInPager maximized
]

{ #category : #accessing }
GtEpiceaStencil >> icon [
	^ BrGlamorousVectorIcons changes
]

{ #category : #accessing }
GtEpiceaStencil >> name [
	^ 'Code Changes'
]
