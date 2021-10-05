Extension { #name : #Class }

{ #category : #'*GToolkit-Extensions' }
Class >> gtAllConfigurationReferencesFor: aView [
	<gtView>
	<gtClassView>

	(self name beginsWith: ConfigurationOf name) ifFalse: [ ^ aView empty ].

	^ aView explicit
		title: 'References';
		tooltip: 'Class and configuration references';
		priority: 40;
		stencil: [ 
			| aName |
			aName := self name withoutPrefix: ConfigurationOf name.
			self gtReferences
			| (('`@receiver configuration: ''', aName, ''' with: `@arg') gtASTMatches) ]
]

{ #category : #'*GToolkit-Extensions' }
Class >> gtAllReferencesFor: aView [
	<gtView>
	<gtClassView>
	
	(self name beginsWith: ConfigurationOf name) ifTrue: [ ^ aView empty ].
	
	^ aView explicit
		title: 'References';
		tooltip: 'Class references';
		priority: 40;
		stencil: [ self gtReferences ]
]
