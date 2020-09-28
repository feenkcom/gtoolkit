Class {
	#name : #GtPlaygroundStencil,
	#superclass : #GtToolStencil,
	#category : #'GToolkit-World-Stencils'
}

{ #category : #converting }
GtPlaygroundStencil >> asPreviewElement [
	^ GtPlayBook newDefault asElement
]

{ #category : #'api - instantiation' }
GtPlaygroundStencil >> create [
	^ GtPlayground create
]

{ #category : #'api - instantiation' }
GtPlaygroundStencil >> createWithSnippets: snippets [
	^ GtPlayground newWithSnippets: snippets
]

{ #category : #accessing }
GtPlaygroundStencil >> name [
	^ 'Playground'
]

{ #category : #'api - opening' }
GtPlaygroundStencil >> openWithSnippets: snippets [
	(self createWithSnippets: snippets) openInPager
]

{ #category : #examples }
GtPlaygroundStencil >> playgroundWithSnippets [
	<gtExample>
	^ GtPlaygroundStencil new createWithSnippets: {'3+4' . '42'}
]
