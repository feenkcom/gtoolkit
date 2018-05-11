partial example definition
documentWithPartialDefinition
	<gtExample>
	<label: 'Document with an example code snippet with partial definition'>
	| aPillarElement aDocument codeSnippet |
	aPillarElement := self pillarElementWithPartialDefinition.
	aDocument := GtDocumenterExamplesUtility documentFromPillarElement: aPillarElement.
	self assert: aDocument codeSnippets size equals: 1.
	codeSnippet := aDocument codeSnippets codeSnippetAt: 1.
	self 
		assert: codeSnippet class 
		equals: GtExampleCodeSnippet.
	self assert: codeSnippet result isNil.
	^ aDocument