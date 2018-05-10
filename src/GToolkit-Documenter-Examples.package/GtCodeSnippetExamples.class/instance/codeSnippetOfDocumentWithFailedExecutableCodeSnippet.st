failed executable code snippet
codeSnippetOfDocumentWithFailedExecutableCodeSnippet
	<gtExample>
	<label: 'Code snippet of a document with an executable code snippet'>
	| aDocument aCodeSnippet anAnnouncements |
	aDocument := self documentWithFailedExecutableCodeSnippet.
	aCodeSnippet := aDocument codeSnippets codeSnippetAt: 1.
	self assert: aCodeSnippet label equals: 'Compute'.
	anAnnouncements := OrderedCollection new.
	aCodeSnippet announcer 
		when: Announcement 
		do: [ :signal | anAnnouncements add: signal ].
	aCodeSnippet executeWithPlaygroundStrategy.
	self assert: aCodeSnippet hasResult.
	self assert: aCodeSnippet result notNil.
	self assert: aCodeSnippet value class equals: ZeroDivide.
	self assert: aCodeSnippet isException.
	self assert: anAnnouncements size equals: 1.
	self assert: anAnnouncements first class equals: GtCodeSnippetFailedExecutionAnnouncement.
	self assert: anAnnouncements first exception class equals: ZeroDivide.
	self assert: anAnnouncements first codeSnippet equals: aCodeSnippet.
	self assert: anAnnouncements first document equals: aDocument.
	^ anAnnouncements first