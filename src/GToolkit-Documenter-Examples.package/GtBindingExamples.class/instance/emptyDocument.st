document
emptyDocument
	<gtExample>
	<label: 'Default document'>
	| aDocument aSubscriptions |
	aDocument := GtDocument new.
	aSubscriptions := SystemAnnouncer uniqueInstance subscriptions subscriptions 
		select: [ :eachSubscription | eachSubscription subscriber = aDocument systemChangesHandler ].
	self assert: aSubscriptions isCollection.
	self assert: aSubscriptions isEmpty.
	^ aDocument