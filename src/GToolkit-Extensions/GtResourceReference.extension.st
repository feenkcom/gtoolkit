Extension { #name : #GtResourceReference }

{ #category : #'*GToolkit-Extensions' }
GtResourceReference >> gtInspectFileReferenceFor: aView [
	<gtAction>
	^ aView button
		label: 'File';
		icon: BrGlamorousVectorIcons inspect;
		tooltip: 'Inspect File Reference';
		priority: 10;
		action: [ :aButton | aButton phlow spawnObject: self fileReference ]
]

{ #category : #'*GToolkit-Extensions' }
GtResourceReference >> gtItemsFor: aView [

	<gtView>
	self exists ifFalse: [ ^ aView empty ].
	self isDirectory ifFalse: [ ^ aView empty ].
	^ aView forward
		  title: 'Items';
		  priority: 5;
		  object: [ self fileReference ];
		  view: #gtItemsFor:
]

{ #category : #'*GToolkit-Extensions' }
GtResourceReference >> gtLocationsFor: aView [
	<gtView>
	self path ifNil: [ ^ aView empty ].
	^ aView columnedList 
		title: 'Locations';
		items: [ self results ];
		column: 'Name' text: [ :aLocation | aLocation printString ];
		column: 'Exists'
			text: [ :aLocation | aLocation exists 
				ifTrue: [ 'available' asRopedText foreground: BrGlamorousColors successBackgroundColor ] 
				ifFalse: [ 'unavailable' asRopedText foreground: BrGlamorousColors errorBackgroundColor ] ] 
			width: 100
]

{ #category : #'*GToolkit-Extensions' }
GtResourceReference >> gtPathFor: aView [
	<gtView>
	^ aView forward
		title: 'Path';
		priority: 10;
		object: [ self fileReference ];
		view: #gtPathFor:
]
