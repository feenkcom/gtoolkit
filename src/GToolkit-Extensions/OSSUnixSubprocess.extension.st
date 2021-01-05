Extension { #name : #OSSUnixSubprocess }

{ #category : #'*GToolkit-Extensions' }
OSSUnixSubprocess >> gtEnvironmentVariablesFor: aView [
	<gtView>
	self envVariables ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Environment Variables';
		priority: 10;
		object: [ self envVariables ];
		view: #gtItemsFor:
]

{ #category : #'*GToolkit-Extensions' }
OSSUnixSubprocess >> gtPathFor: aView [
	<gtView>
	self envVariables ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Path';
		priority: 11;
		object: [ (self envVariables 
			at: 'PATH'
			ifPresent: [ :aString | $: split: aString ]
			ifAbsent: [ #() ]) ];
		view: #gtItemsFor:
]
