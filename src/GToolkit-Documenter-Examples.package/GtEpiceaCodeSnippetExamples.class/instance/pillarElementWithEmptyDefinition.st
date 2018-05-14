empty definition
pillarElementWithEmptyDefinition
	<gtExample>
	<label: 'Pillar element with an example code snippet with empty definition'>
	| fileReference pillarElement |
	fileReference := self fileReferenceWithEmptyDefinition.
	pillarElement := GtDocumenterExamplesUtility pillarElementForPillarFileReference: fileReference.
	(GtDocumenterExamplesUtility editorFromPillarElement: pillarElement) styleText.
	self assert: pillarElement notNil.
	^ pillarElement