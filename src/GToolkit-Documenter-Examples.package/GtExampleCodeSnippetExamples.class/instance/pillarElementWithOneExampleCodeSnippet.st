simple example definition
pillarElementWithOneExampleCodeSnippet
	<gtExample>
	<label: 'Pillar element with an example code snippet'>
	| fileReference pillarElement |
	fileReference := self fileReferenceWithOneExampleCodeSnippet.
	pillarElement := GtDocumenterExamplesUtility pillarElementForPillarFileReference: fileReference.
	self assert: pillarElement notNil.
	(GtDocumenterExamplesUtility editorFromPillarElement: pillarElement) styleText.
	^ pillarElement