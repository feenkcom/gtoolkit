editing document
textEditorWithTwoCodeSnippets
	<gtExample>
	<label: 'Text editor'>
	| pillarElement editor |
	pillarElement := self pillarElementWithTwoCodeSnippets.
	editor := pillarElement contentElement editor.
	self assert: editor notNil.
	self assert: editor styler workspace notNil.
	self assert: editor styler workspace outs size equals: 2.
	^ editor