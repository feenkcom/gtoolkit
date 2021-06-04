"
I am an ${class:BlElement}$.
I summarize a file content for a given ${method:GtHomeFileDocumentCardElement>>#file:|label=file}$.
!! Examples
!!! Existing file
${example:GtHomeFileDocumentCardElementExamples>>#elementWithFilledFile|codeExpanded=false|previewExpanded=true}$
!!! Existing empty file
${example:GtHomeFileDocumentCardElementExamples>>#elementWithEmptyFile|codeExpanded=false|previewExpanded=true}$
!!! Inexistent file
${example:GtHomeFileDocumentCardElementExamples>>#elementWithInexistentFile|codeExpanded=false|previewExpanded=true}$

"
Class {
	#name : #GtHomeFileDocumentCardElement,
	#superclass : #GtHomeDocumentCardElement,
	#category : #'GToolkit-World-Sections'
}

{ #category : #'private - accessing' }
GtHomeFileDocumentCardElement >> description [
	| aComment aDescription |
	aComment := self limitedFileContent.
	aDescription := String 
		streamContents: [ :aStream |
			| reachedSecondLine hasCharacters |
			reachedSecondLine := false.
			hasCharacters := false.
			aComment do: [ :eachCharacter | 
				reachedSecondLine ifTrue: [ 
					(hasCharacters not and: [ 
						eachCharacter isLineBreak ])
							ifFalse: [ 
								aStream nextPut: eachCharacter.
								hasCharacters := true ] ].
				eachCharacter isLineBreak
					ifTrue: [ reachedSecondLine := true ] ] ]
		limitedTo: self maxDescriptionLenght.
	^ aDescription
]

{ #category : #'api - accessing' }
GtHomeFileDocumentCardElement >> documentClass [
	^ self document
]

{ #category : #'api - accessing' }
GtHomeFileDocumentCardElement >> documentClass: aClass [
	self document: aClass instanceSide.
]

{ #category : #'api - accessing' }
GtHomeFileDocumentCardElement >> file [
	^ self document
]

{ #category : #'api - accessing' }
GtHomeFileDocumentCardElement >> file: aFile [
	self document: aFile.
]

{ #category : #'private - accessing' }
GtHomeFileDocumentCardElement >> fileReference [
	^ self file asFileReference
]

{ #category : #'private - accessing' }
GtHomeFileDocumentCardElement >> limitedFileContent [
	<return: #String>
	| aFileRefernece |
	aFileRefernece := self fileReference.
	aFileRefernece exists ifFalse: [ ^ '' ].
	aFileRefernece isFile ifFalse: [ ^ '' ].
	aFileRefernece isReadable ifFalse: [ ^ '' ].
	^ String
		streamContents: [ :aStringStream |
			aFileRefernece readStreamEncoded: #utf8 do: [ :aFileStream | 
				[ aFileStream atEnd ] whileFalse: [ 
					aStringStream nextPut: aFileStream next ] ] ]
		limitedTo: self maxTitleLenght + self maxDescriptionLenght + 10.
]

{ #category : #'private - hooks' }
GtHomeFileDocumentCardElement >> onDocumentChanged [
	self updateElement.
]

{ #category : #'private - accessing' }
GtHomeFileDocumentCardElement >> title [
	| aComment aTitle |
	aComment := self limitedFileContent.
	aTitle := self titleWithoutHeadingsFrom: aComment.
	aTitle ifEmpty: [ ^ self fileReference basename ].
	^ aTitle
]
