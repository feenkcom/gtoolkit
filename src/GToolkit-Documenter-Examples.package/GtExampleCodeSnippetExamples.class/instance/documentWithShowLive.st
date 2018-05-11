example with show live parameter
documentWithShowLive
	<gtExample>
	<label: 'Document with an example code snippet with showLive'>
	| aPillarElement aDocument codeSnippet |
	aPillarElement := self pillarElementWithShowLive.
	aDocument := GtDocumenterExamplesUtility documentFromPillarElement: aPillarElement.
	self assert: aDocument codeSnippets size equals: 1.
	codeSnippet := aDocument codeSnippets codeSnippetAt: 1.
	self 
		assert: codeSnippet class 
		equals: GtExampleCodeSnippet.
	self assert: codeSnippet result isNil.
	^ aDocument