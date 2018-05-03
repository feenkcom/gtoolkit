document
outsFromDocumentWithOneCodeSnippet
	<gtExample>
	<label: 'Default document'>
	| document outs |
	document := self documentWithOneCodeSnippet.
	outs := document bindingOf: GtDocumenterConstants resultsVariableName.
	self assert: outs notNil.
	self
		assert: outs key
		equals: GtDocumenterConstants resultsVariableName.
	self assert: outs value notNil.
	self assert: outs value size equals: 1.
	self assert: (outs value at: 1) equals: 108.
	^ outs value