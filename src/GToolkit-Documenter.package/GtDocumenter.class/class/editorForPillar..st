opening
editorForPillar: aPillarFile
	| aFileReference |
	
	aFileReference := aPillarFile asFileReference.

	^ self
		editorForText: aFileReference contents
		fileReference: aFileReference