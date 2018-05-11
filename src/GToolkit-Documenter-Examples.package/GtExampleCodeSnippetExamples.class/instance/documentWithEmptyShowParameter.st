example with empty show definition
documentWithEmptyShowParameter
	<gtExample>
	<label: 'Document with an example code snippet with an empty show parameter'>
	| aPillarElement aDocument codeSnippet |
	aPillarElement := self pillarElementWithEmptyShowParameter.
	aDocument := GtDocumenterExamplesUtility documentFromPillarElement: aPillarElement.
	self assert: aDocument codeSnippets size equals: 1.
	codeSnippet := aDocument codeSnippets codeSnippetAt: 1.
	self 
		assert: codeSnippet class 
		equals: GtExampleCodeSnippet.
	self assert: codeSnippet result isNil.
	^ aDocument