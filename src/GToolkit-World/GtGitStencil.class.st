Class {
	#name : #GtGitStencil,
	#superclass : #GtToolStencil,
	#category : #'GToolkit-World-Stencils'
}

{ #category : #converting }
GtGitStencil >> asPreviewElement [
	^ GtInspector forObject: Gt4Git new allRepositoriesGroup
]

{ #category : #'api - instantiation' }
GtGitStencil >> create [
	^ (GtInspector createOn: Gt4Git new allRepositoriesGroup) maximized.
]

{ #category : #accessing }
GtGitStencil >> name [
	^ 'Git'
]
