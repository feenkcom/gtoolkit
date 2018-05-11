example with show live parameter
pillarElementWithShowLive
	<gtExample>
	<label: 'Pillar element with an example code snippet with showLive'>
	| fileReference pillarElement |
	fileReference := self fileReferenceWithShowLive.
	pillarElement := GtDocumenterExamplesUtility pillarElementForPillarFileReference: fileReference.
	(GtDocumenterExamplesUtility editorFromPillarElement: pillarElement) styleText.
	self assert: pillarElement notNil.
	^ pillarElement