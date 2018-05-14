empty definition
documentWithEmptyDefinition
	<gtExample>
	<label: 'Document with an example code snippet with empty definition'>
	| aPillarElement aDocument codeSnippet |
	aPillarElement := self pillarElementWithEmptyDefinition.
	aDocument := GtDocumenterExamplesUtility documentFromPillarElement: aPillarElement.
	self assert: aDocument codeSnippets size equals: 1.
	codeSnippet := aDocument codeSnippets codeSnippetAt: 1.
	self 
		assert: codeSnippet class 
		equals: GtEpiceaCodeSnippet.
	self assert: codeSnippet result isNil.
	^ aDocument