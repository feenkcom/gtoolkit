simple example definition
documentWithOneExampleCodeSnippet
	<gtExample>
	<label: 'Document with an example code snippet'>
	| aPillarElement aDocument codeSnippet |
	aPillarElement := self pillarElementWithOneExampleCodeSnippet.
	aDocument := GtDocumenterExamplesUtility documentFromPillarElement: aPillarElement.
	self assert: aDocument codeSnippets size equals: 1.
	codeSnippet := aDocument codeSnippets codeSnippetAt: 1.
	self 
		assert: codeSnippet class 
		equals: GtExampleCodeSnippet.
	self assert: codeSnippet result isNil.
	^ aDocument