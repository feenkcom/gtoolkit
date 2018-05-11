utility
pillarElementForPillarFileReference: aFileReference
	<return: #GtPillarEditorElement>
	| pillarElement document editor |
	pillarElement := GtDocumenter editorForPillar: aFileReference.
	self assert: pillarElement notNil.
	document := pillarElement document.
	editor := self editorElementFromPillarElement: pillarElement.
	self assert: document notNil.
	self assert: editor notNil.
	self assert: document outs notNil.
	^ pillarElement