"
I exemplify ${class:GtHomeClassCommentCardElement}$.
"
Class {
	#name : #GtHomeClassCommentCardElementExamples,
	#superclass : #GtHomeDocumentCardElementExamples,
	#category : #'GToolkit-World-Examples'
}

{ #category : #'examples - basic' }
GtHomeClassCommentCardElementExamples >> basicElement [
	<gtExample>
	| anElement |
	anElement := GtHomeClassCommentCardElement new.
	self assert: anElement documentClass isNil.
	self assert: anElement titleElement text isEmpty.
	self assert: anElement descriptionElement text isEmpty.
	^ anElement
]

{ #category : #accessing }
GtHomeClassCommentCardElementExamples >> elementWithClassWithComment [
	<gtExample>
	| anElement |
	anElement := self basicElement.
	anElement documentClass: anElement class.

	self assert: anElement titleElement text isNotEmpty.
	self assert: anElement descriptionElement text isNotEmpty.
	
	self 
		assert: anElement titleElement text asString
		equals: anElement class comment lines first.

	self 
		assert: anElement descriptionElement text asString
		equals: anElement description.
			
	^ anElement
]

{ #category : #'examples - element' }
GtHomeClassCommentCardElementExamples >> elementWithClassWithoutComment [
	<gtExample>
	| anElement |
	anElement := self basicElement.
	anElement documentClass: GtHomeClassWithoutClassComment.
	self assert: anElement titleElement text asString equals: GtHomeClassWithoutClassComment name.
	self assert: anElement descriptionElement text isEmpty.
	^ anElement
]
