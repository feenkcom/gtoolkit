document registered to system changes
registeredDocument
	<gtExample>
	<label: 'Ensure that document is registered to system changes'>
	| aDocument aSubscriptions aCodeSnippet |
	aDocument := self emptyDocument.
	aCodeSnippet := GtExampleCodeSnippet new.
	aCodeSnippet index: 1.
	aCodeSnippet document: aDocument.
	aSubscriptions := SystemAnnouncer uniqueInstance subscriptions subscriptions 
		select: [ :eachSubscription | eachSubscription subscriber = aDocument systemChangesHandler ].
	self assert: aSubscriptions isCollection.
	self assert: aSubscriptions size equals: 1.
	self assert: (aSubscriptions anyOne isKindOf: WeakAnnouncementSubscription).
	^ aDocument.