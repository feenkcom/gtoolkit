example with expanded preview
documentWithExpandedPreview
	<gtExample>
	<label: 'Document with an example code snippet with expanded preview'>
	| aPillarElement aDocument codeSnippet |
	aPillarElement := self pillarElementWithExpandedPreview.
	aDocument := GtDocumenterExamplesUtility documentFromPillarElement: aPillarElement.
	self assert: aDocument codeSnippets size equals: 1.
	codeSnippet := aDocument codeSnippets codeSnippetAt: 1.
	self 
		assert: codeSnippet class 
		equals: GtExampleCodeSnippet.
	self assert: codeSnippet result isNil.
	^ aDocument