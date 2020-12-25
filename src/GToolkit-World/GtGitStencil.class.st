Class {
	#name : #GtGitStencil,
	#superclass : #GtToolStencil,
	#category : #'GToolkit-World-Stencils'
}

{ #category : #converting }
GtGitStencil >> asPreviewElement [
	^ GtInspector forObject: Gt4Git new
]

{ #category : #'api - instantiation' }
GtGitStencil >> create [
	^ (GtInspector createOn: Gt4Git new) maximized.
]

{ #category : #accessing }
GtGitStencil >> icon [
	^ BrGlamorousVectorIcons emphasizedInspect
]

{ #category : #accessing }
GtGitStencil >> name [
	^ 'Git'
]
