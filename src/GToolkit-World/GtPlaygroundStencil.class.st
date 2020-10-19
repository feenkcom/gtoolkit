Class {
	#name : #GtPlaygroundStencil,
	#superclass : #GtToolStencil,
	#classInstVars : [
		'playgroundClassName'
	],
	#category : #'GToolkit-World-Stencils'
}

{ #category : #accessing }
GtPlaygroundStencil class >> defaultPlaygroundClass [
	^ GtPlayground
]

{ #category : #accessing }
GtPlaygroundStencil class >> playgroundClass [
	^ self playgroundClassName 
		ifNil: [ self defaultPlaygroundClass ]
		ifNotNil: [ :aClassName |
			self environment 
				at: aClassName 
				ifAbsent: [ self defaultPlaygroundClass ] ]
]

{ #category : #accessing }
GtPlaygroundStencil class >> playgroundClassName [
	^ playgroundClassName
]

{ #category : #accessing }
GtPlaygroundStencil class >> playgroundClassName: aClassName [
	playgroundClassName := aClassName
]

{ #category : #converting }
GtPlaygroundStencil >> asPreviewElement [
	^ GtPlayBook newDefault asElement
]

{ #category : #'api - instantiation' }
GtPlaygroundStencil >> create [
	^ self class playgroundClass create
]

{ #category : #'api - instantiation' }
GtPlaygroundStencil >> createWithSnippets: snippets [
	^ self class playgroundClass newWithSnippets: snippets
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
