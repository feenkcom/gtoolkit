"
I exemplify ${class:GtHomeFileDocumentCardElement}$.
"
Class {
	#name : #GtHomeFileDocumentCardElementExamples,
	#superclass : #GtHomeDocumentCardElementExamples,
	#category : #'GToolkit-World-Examples'
}

{ #category : #'examples - basic' }
GtHomeFileDocumentCardElementExamples >> basicElement [
	<gtExample>
	| anElement |
	anElement := GtHomeFileDocumentCardElement new.
	self assert: anElement file isNil.
	self assert: anElement titleElement text isEmpty.
	self assert: anElement descriptionElement text isEmpty.
	^ anElement
]

{ #category : #'examples - element' }
GtHomeFileDocumentCardElementExamples >> elementWithEmptyFile [
	<gtExample>
	| anElement |
	anElement := self basicElement.
	anElement file: self existingEmptyFile.
	self 
		assert: anElement titleElement text asString 
		equals: anElement file basename.
	self assert: anElement descriptionElement text isEmpty.
	^ anElement
]

{ #category : #accessing }
GtHomeFileDocumentCardElementExamples >> elementWithFilledFile [
	<gtExample>
	| anElement |
	anElement := self basicElement.
	anElement file: self existingFilledFile.
	
	self
		assert: anElement titleElement text size
		equals: anElement maxTitleLenght.
	self 
		assert: anElement titleElement text asString 
		equals: 'Lorem ipsum dolor sit amet, co'.
		
	self 
		assert: anElement descriptionElement text isNotEmpty
		description: 'Description must be non-empty'.
	self 
		assert: anElement descriptionElement text size <= anElement maxDescriptionLenght.
	^ anElement
]

{ #category : #'examples - element' }
GtHomeFileDocumentCardElementExamples >> elementWithInexistentFile [
	<gtExample>
	| anElement |
	anElement := self basicElement.
	anElement file: self inexistentFile.
	self 
		assert: anElement titleElement text asString 
		equals: anElement file basename.
	self assert: anElement descriptionElement text isEmpty.
	^ anElement
]

{ #category : #'examples - model' }
GtHomeFileDocumentCardElementExamples >> existingEmptyFile [
	<gtExample>
	| aFile |
	aFile := self fileSystem workingDirectory / 'existing-file.txt'.
	aFile ensureCreateFile.
	self assert: aFile exists.
	self assert: aFile size equals: 0.
	^ aFile
]

{ #category : #'examples - model' }
GtHomeFileDocumentCardElementExamples >> existingFilledFile [
	<gtExample>
	| aFile |
	aFile := self fileSystem workingDirectory / 'existing-file.txt'.
	aFile writeStreamEncoded: #utf8 do: [ :aStream |
		aStream nextPutAll: '!! '.
		aStream nextPutAll: (String loremIpsum: 100).
		aStream crlf.
		aStream nextPutAll: (String loremIpsum: 1000) ].
	self assert: aFile exists.
	self assert: aFile size equals: 1105.
	^ aFile
]

{ #category : #'examples - model' }
GtHomeFileDocumentCardElementExamples >> fileSystem [
	<gtExample>
	^ FileSystem memory
]

{ #category : #'examples - model' }
GtHomeFileDocumentCardElementExamples >> inexistentFile [
	<gtExample>
	| aFile |
	aFile := self fileSystem workingDirectory / 'inexistent-file.txt'.
	self assert: aFile exists not.
	^ aFile
]
