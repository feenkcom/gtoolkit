executable code snippet
documentWithOneExecutableCodeSnippet
	<gtExample>
	<label: 'Document with an executable code snippet'>
	| aPillarElement aDocument |
	aPillarElement := self pillarElementWithOneExecutableCodeSnippet.
	aDocument := self documentFromPillarElement: aPillarElement.
	self assert: aDocument codeSnippets size equals: 1.
	self 
		assert: (aDocument codeSnippets codeSnippetAt: 1) class 
		equals: GtExecutableCodeSnippet.
	^ aDocument