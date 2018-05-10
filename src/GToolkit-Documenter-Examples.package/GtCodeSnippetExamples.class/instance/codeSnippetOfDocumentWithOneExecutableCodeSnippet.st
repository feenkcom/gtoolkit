executable code snippet
codeSnippetOfDocumentWithOneExecutableCodeSnippet
	<gtExample>
	<label: 'Code snippet of a document with an executable code snippet'>
	| aDocument aCodeSnippet anAnnouncements |
	aDocument := self documentWithOneExecutableCodeSnippet.
	aCodeSnippet := aDocument codeSnippets codeSnippetAt: 1.
	anAnnouncements := OrderedCollection new.
	aCodeSnippet announcer 
		when: Announcement 
		do: [ :signal | anAnnouncements add: signal ].
	aCodeSnippet executeWithPlaygroundStrategy.
	self assert: anAnnouncements size equals: 1.
	self assert: anAnnouncements first class equals: GtCodeSnippetSuccessfulExecutionSignal.
	self assert: anAnnouncements first newValue equals: 24.
	self assert: anAnnouncements first codeSnippet equals: aCodeSnippet.
	self assert: anAnnouncements first document equals: aDocument.
	^ anAnnouncements first