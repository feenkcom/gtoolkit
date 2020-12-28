Class {
	#name : #GtHomeDocumentCardElement,
	#superclass : #GtHomeCardElement,
	#instVars : [
		'descriptionElement',
		'titleElement',
		'document'
	],
	#category : #'GToolkit-World-Sections'
}

{ #category : #'instance creation' }
GtHomeDocumentCardElement class >> forClass: aClass [
	^ GtHomeClassCommentCardElement new
		documentClass: aClass
]

{ #category : #'instance creation' }
GtHomeDocumentCardElement class >> forFile: aFile [
	^ GtHomeFileDocumentCardElement new
		file: aFile
]

{ #category : #'private - accessing' }
GtHomeDocumentCardElement >> description [
	<return: #String>
	^ self subclassResponsibility
]

{ #category : #'private - accessing' }
GtHomeDocumentCardElement >> descriptionElement [
	<return: #BrEditor>
	^ descriptionElement
]

{ #category : #'api - accessing' }
GtHomeDocumentCardElement >> document [
	<return: #Object>
	^ document
]

{ #category : #'api - accessing' }
GtHomeDocumentCardElement >> document: anObject [
	document = anObject ifTrue: [ ^ self ].
	self unsubscribeFromDocument.
	document := anObject.
	self subscribeToDocument.
	self onDocumentChanged.
]

{ #category : #initialization }
GtHomeDocumentCardElement >> initialize [
	super initialize.
	self initializeTitleElement.
	self initializeDescriptionElement.
	
	self addChild: self titleElement as: #title.
	self addChild: self descriptionElement as: #description.
	
	self addLook: (BrLayoutResizerLook new
		hInherit: self titleElement;
		vAnyToFitContent: self titleElement;
		inherit: self descriptionElement).
]

{ #category : #initialization }
GtHomeDocumentCardElement >> initializeDescriptionElement [
	descriptionElement := BrEditor new
		look: (BrGlamorousEditorLook new 
			glamorousRegularFont; 
			fontSize: 9);
		matchParent;
		beReadOnlyWithoutSelection
]

{ #category : #initialization }
GtHomeDocumentCardElement >> initializeTitleElement [
	titleElement := BrEditor new
		look: (BrGlamorousEditorLook new 
			glamorousRegularFont;
			bold;
			fontSize: 12);
		hMatchParent;
		vFitContent;
		beReadOnlyWithoutSelection.
]

{ #category : #defaults }
GtHomeDocumentCardElement >> maxDescriptionLenght [
	^ 400
]

{ #category : #defaults }
GtHomeDocumentCardElement >> maxTitleLenght [
	^ 30
]

{ #category : #'private - hooks' }
GtHomeDocumentCardElement >> onDocumentChanged [
]

{ #category : #'private - subscriptions' }
GtHomeDocumentCardElement >> subscribeToDocument [
]

{ #category : #'private - accessing' }
GtHomeDocumentCardElement >> title [
	<return: #String>
	^ self subclassResponsibility
]

{ #category : #'private - accessing' }
GtHomeDocumentCardElement >> titleElement [
	<return: #BrEditor>
	^ titleElement
]

{ #category : #'private - accessing' }
GtHomeDocumentCardElement >> titleWithoutHeadingsFrom: aComment [
	^ String 
		streamContents: [ :aStream |
			| hasCharacters |
			hasCharacters := false.
			aComment do: [ :eachCharacter |
				eachCharacter isLineBreak
					ifTrue: [ ^ aStream contents ]
					ifFalse: [ hasCharacters 
						ifTrue: [ aStream nextPut: eachCharacter ]
						ifFalse: [ (#($  $!) includes: eachCharacter)
							ifFalse: [ 
								aStream nextPut: eachCharacter.
								hasCharacters := true ] ] ] ] ]
		limitedTo: self maxTitleLenght.
]

{ #category : #'private - subscriptions' }
GtHomeDocumentCardElement >> unsubscribeFromDocument [
]

{ #category : #'private - updating' }
GtHomeDocumentCardElement >> updateDescriptionElement [
	self descriptionElement text: self description.
]

{ #category : #'private - updating' }
GtHomeDocumentCardElement >> updateElement [
	self updateTitleElement.
	self updateDescriptionElement.
]

{ #category : #'private - updating' }
GtHomeDocumentCardElement >> updateTitleElement [
	self titleElement text: self title.
]
