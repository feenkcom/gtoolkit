non-existent example method
pillarElementWithNonExistentExampleMethod
	<gtExample>
	<label: 'Pillar element with an example code snippet with non-existent example method'>
	| fileReference pillarElement |
	fileReference := self fileReferenceWithNonExistentExampleMethod.
	pillarElement := GtDocumenterExamplesUtility pillarElementForPillarFileReference: fileReference.
	(GtDocumenterExamplesUtility editorFromPillarElement: pillarElement) styleText.
	self assert: pillarElement notNil.
	^ pillarElement