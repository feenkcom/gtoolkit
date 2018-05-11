example with expanded preview
pillarElementWithExpandedPreview
	<gtExample>
	<label: 'Pillar element with an example code snippet with expanded preview'>
	| fileReference pillarElement |
	fileReference := self fileReferenceWithExpandedPreview.
	pillarElement := GtDocumenterExamplesUtility pillarElementForPillarFileReference: fileReference.
	(GtDocumenterExamplesUtility editorFromPillarElement: pillarElement) styleText.
	self assert: pillarElement notNil.
	^ pillarElement