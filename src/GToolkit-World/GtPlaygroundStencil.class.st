Class {
	#name : 'GtPlaygroundStencil',
	#superclass : 'GtToolStencil',
	#instVars : [
		'knowledgeBase'
	],
	#classInstVars : [
		'playgroundClassName'
	],
	#category : 'GToolkit-World-Stencils'
}

{ #category : 'accessing' }
GtPlaygroundStencil class >> defaultPlaygroundClass [
	^ LePlayground
]

{ #category : 'accessing' }
GtPlaygroundStencil class >> playgroundClass [
	^ self playgroundClassName 
		ifNil: [ self defaultPlaygroundClass ]
		ifNotNil: [ :aClassName |
			self environment 
				at: aClassName 
				ifAbsent: [ self defaultPlaygroundClass ] ]
]

{ #category : 'accessing' }
GtPlaygroundStencil class >> playgroundClassName [
	^ playgroundClassName
]

{ #category : 'accessing' }
GtPlaygroundStencil class >> playgroundClassName: aClassName [
	playgroundClassName := aClassName
]

{ #category : 'converting' }
GtPlaygroundStencil >> asPreviewElement [
	| notePage toolElement |
	notePage := LePlayground newBasicPharoCodePage.
	toolElement := notePage asLepiterPagePhlowToolWithoutFocus 
		asElementDo: [ :e | e ].
	
	^ toolElement
		padding: (BlInsets all: 10)
]

{ #category : 'api - instantiation' }
GtPlaygroundStencil >> create [
	^ self class playgroundClass 
			createWithPharoCodPageInKnowledgeBase: self currentKnowledgeBase
]

{ #category : 'api - instantiation' }
GtPlaygroundStencil >> createWithSnippets: snippets [
	^ self class playgroundClass newWithSnippets: snippets
]

{ #category : 'accessing' }
GtPlaygroundStencil >> currentKnowledgeBase [
	^ self knowledgeBase ifNil: [
		LeDatabasesRegistry uniqueInstance currentLoadedDefaultLogicalDatabase ]
]

{ #category : 'accessing' }
GtPlaygroundStencil >> icon [
	^ self class playgroundClass defaultIcon
]

{ #category : 'accessing' }
GtPlaygroundStencil >> knowledgeBase [
	^ knowledgeBase
]

{ #category : 'accessing' }
GtPlaygroundStencil >> knowledgeBase: aKnowledgeBase [
	knowledgeBase := aKnowledgeBase
]

{ #category : 'accessing' }
GtPlaygroundStencil >> name [
	^ 'Playground'
]

{ #category : 'api - opening' }
GtPlaygroundStencil >> openWithSnippets: snippets [
	(self createWithSnippets: snippets) openInPager
]

{ #category : 'examples' }
GtPlaygroundStencil >> playgroundWithSnippets [
	<gtExample>
	^ GtPlaygroundStencil new createWithSnippets: {'3+4' . '42'}
]
