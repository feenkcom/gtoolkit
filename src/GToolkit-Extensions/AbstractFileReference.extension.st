Extension { #name : #AbstractFileReference }

{ #category : #'*GToolkit-Extensions' }
AbstractFileReference >> gtLepiterDuplicateJsonFor: aView [
	<gtView>
	(self isFile and: [ self extension = 'duplicate' ]) ifFalse: [ ^ aView empty ].
	^ aView textEditor
		title: 'Lepiter Duplicate';
		priority: 1;
		actionButtonIcon: BrGlamorousIcons tree
			label: 'JSON'
			tooltip: 'Parse with a JSON parse'
			action: [ :aButton | aButton phlow spawnObject: (STONJSON fromString: self contents) ];
		actionButtonIcon: BrGlamorousIcons tree
			label: 'Lepiter'
			tooltip: 'Parse with a Lepiter parser'
			action: [ :aButton | 
				aButton phlow
					spawnObject: (self
							readStreamEncoded: #utf8
							do: [ :aStream | LeJsonV4 uniqueInstance deserialize: aStream ]) ];
		aptitude: [ BrGlamorousCodeEditorAptitude ];
		styler: [ JSONParser gtStyler ];
		text: [ STONJSON toStringPretty: (STONJSON fromString: self contents) ]
]
