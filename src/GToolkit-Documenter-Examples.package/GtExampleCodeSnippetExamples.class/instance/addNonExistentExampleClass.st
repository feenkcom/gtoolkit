adding non-existent example class
addNonExistentExampleClass
	<gtExample>
	<label: 'Add non-existent example class'>
	| aCodeSnippet anAnnouncements |
	aCodeSnippet := self codeSnippetOfDocumentWithNonExistentExampleClass.
	self assert: aCodeSnippet isMethodClassDefined not.
	anAnnouncements := OrderedCollection new.
	aCodeSnippet subscribe: GtDocumentAnnouncement do: [ :anAnnouncement | 
		anAnnouncements add: anAnnouncement ].
	GtDocumenterExamplesUtility 
		createClassNamed: aCodeSnippet methodClassName 
		during: [ 
			self assert: anAnnouncements size equals: 1.
			self assert: anAnnouncements first class equals: GtExampleClassUpdatedAnnouncement.
			self assert: anAnnouncements first codeSnippet equals: aCodeSnippet.
			self assert: anAnnouncements first document equals: aCodeSnippet bindings ].
	self assert: anAnnouncements size equals: 2.
	self assert: anAnnouncements second class equals: GtExampleClassUpdatedAnnouncement.
	self assert: anAnnouncements second codeSnippet equals: aCodeSnippet.
	self assert: anAnnouncements second document equals: aCodeSnippet bindings.
	^ aCodeSnippet