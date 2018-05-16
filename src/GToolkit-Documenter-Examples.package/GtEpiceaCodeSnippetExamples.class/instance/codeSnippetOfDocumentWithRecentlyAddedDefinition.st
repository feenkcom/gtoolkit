add event to non-existent ombu file
codeSnippetOfDocumentWithRecentlyAddedDefinition
	<gtExample>
	<label: 'Code snippet of a document with an example code snippet with recently added definition'>
	| aCodeSnippet anEpEvent anEpLog anAnnouncements |
	aCodeSnippet := self codeSnippetOfDocumentWithEmptyDefinition.
	anEpLog := EpLog fromFile: self ombuFileReferenceWithClassDefinition.
	self assert: anEpLog entries size equals: 1.
	anEpEvent := anEpLog entries first.
	self assert: aCodeSnippet epiceaLog ombuFile exists not.
	anAnnouncements := OrderedCollection new.
	aCodeSnippet epiceaLog onImpactChangedDo: [ :anAnnouncement | anAnnouncements add: anAnnouncement ].
	aCodeSnippet epiceaLog addEntryWith: anEpEvent content tags: [ :tags |  ].
	aCodeSnippet epiceaLog flush.
	self assert: aCodeSnippet epiceaLog ombuFile exists.
	self assert: anAnnouncements size equals: 1.
	self assert: anAnnouncements first class equals: GtEpiceaImpactChangedAnnouncement.
	self assert: anAnnouncements first hasImpact.
	^ aCodeSnippet