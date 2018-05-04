editing document
pillarElementWithTwoCodeSnippets
	<gtExample>
	<label: 'Pillar Bloc element'>
	| rootDocument pillarElement document editor |
	rootDocument := self rootDocumentForAddingAndRemovingCodeSnippets.
	pillarElement := GtDocumenter editorForPillar: rootDocument.
	self assert: pillarElement notNil.
	document := pillarElement document.
	editor := pillarElement contentElement editor.
	self assert: document notNil.
	self assert: editor notNil.
	self assert: document outs size equals: 2.
	^ pillarElement