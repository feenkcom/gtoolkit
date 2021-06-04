"
I am an ${class:BlElement}$.
I summarize a class comment for a given ${method:GtHomeClassCommentCardElement>>#documentClass:|label=class}$.
!! Examples
!!! Existing class comment
${example:GtHomeClassCommentCardElementExamples>>#elementWithClassWithComment|codeExpanded=false|previewExpanded=true}$
!!! Empty class comment
${example:GtHomeClassCommentCardElementExamples>>#elementWithClassWithoutComment|codeExpanded=false|previewExpanded=true}$

"
Class {
	#name : #GtHomeClassCommentCardElement,
	#superclass : #GtHomeDocumentCardElement,
	#category : #'GToolkit-World-Sections'
}

{ #category : #'private - accessing' }
GtHomeClassCommentCardElement >> description [
	| aComment aDescription reachedSecondLine |
	aComment := self documentClass organization classComment.
	reachedSecondLine := false.
	aDescription := String 
		streamContents: [ :aStream |
			aComment do: [ :eachCharacter | 
				reachedSecondLine ifTrue: [ 
					aStream nextPut: eachCharacter ].
				eachCharacter isLineBreak
					ifTrue: [ reachedSecondLine := true ] ] ]
		limitedTo: self maxDescriptionLenght.
	^ aDescription
]

{ #category : #'api - accessing' }
GtHomeClassCommentCardElement >> documentClass [
	^ self document
]

{ #category : #'api - accessing' }
GtHomeClassCommentCardElement >> documentClass: aClass [
	self document: aClass instanceSide.
]

{ #category : #'private - hooks' }
GtHomeClassCommentCardElement >> onDocumentChanged [
	self updateElement.
]

{ #category : #'private - accessing' }
GtHomeClassCommentCardElement >> title [
	| aComment aTitle |
	aComment := self documentClass organization classComment.
	aTitle := self titleWithoutHeadingsFrom: aComment.
	aTitle ifEmpty: [ ^ self documentClass name ].
	^ aTitle
]
