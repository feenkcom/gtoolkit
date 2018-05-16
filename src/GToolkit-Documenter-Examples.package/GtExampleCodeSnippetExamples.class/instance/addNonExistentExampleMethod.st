adding non-existent example class
addNonExistentExampleMethod
	<gtExample>
	<label: 'Add non-existent example method'>
	| aCodeSnippet anAnnouncements |
	aCodeSnippet := self codeSnippetOfDocumentWithNonExistentExampleClass.
	self assert: aCodeSnippet isMethodClassDefined not.
	self assert: aCodeSnippet isMethodDefined not.
	anAnnouncements := OrderedCollection new.
	aCodeSnippet subscribe: GtDocumentAnnouncement do: [ :anAnnouncement | 
		anAnnouncements add: anAnnouncement ].
	GtDocumenterExamplesUtility 
		createClassNamed: aCodeSnippet methodClassName 
		during: [ :theClass | 
			self assert: anAnnouncements size equals: 1.
			theClass compile: aCodeSnippet methodSelectorName classified: 'example'.
			self assert: anAnnouncements size equals: 2.
			self assert: anAnnouncements second class equals: GtExampleClassUpdatedAnnouncement.
			self assert: anAnnouncements first codeSnippet equals: aCodeSnippet.
			self assert: anAnnouncements first document equals: aCodeSnippet bindings.
			self assert: aCodeSnippet isMethodClassDefined.
			self assert: aCodeSnippet isMethodDefined ].
	self assert: anAnnouncements size equals: 3.
	self assert: anAnnouncements third class equals: GtExampleClassUpdatedAnnouncement.
	self assert: anAnnouncements third codeSnippet equals: aCodeSnippet.
	self assert: anAnnouncements third document equals: aCodeSnippet bindings.
	^ aCodeSnippet