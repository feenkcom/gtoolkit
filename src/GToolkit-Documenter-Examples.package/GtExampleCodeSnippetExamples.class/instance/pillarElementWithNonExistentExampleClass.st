non-existent example class
pillarElementWithNonExistentExampleClass
	<gtExample>
	<label: 'Pillar element with an example code snippet with non-existent example class'>
	| fileReference pillarElement |
	fileReference := self fileReferenceWithNonExistentExampleClass.
	pillarElement := GtDocumenterExamplesUtility pillarElementForPillarFileReference: fileReference.
	(GtDocumenterExamplesUtility editorFromPillarElement: pillarElement) styleText.
	self assert: pillarElement notNil.
	^ pillarElement