Class {
	#name : #GtGitStencil,
	#superclass : #GtToolStencil,
	#category : #'GToolkit-World-Stencils'
}

{ #category : #converting }
GtGitStencil >> asPreviewElement [
	^ GtGitElement new asElement
]

{ #category : #'api - instantiation' }
GtGitStencil >> create [
	^ GtGitElement new createInPager maximized
]

{ #category : #accessing }
GtGitStencil >> icon [
	^ BrGlamorousVectorIcons branching
]

{ #category : #accessing }
GtGitStencil >> name [
	^ 'Git'
]
