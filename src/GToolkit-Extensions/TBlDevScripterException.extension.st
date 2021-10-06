Extension { #name : #TBlDevScripterException }

{ #category : #'*GToolkit-Extensions' }
TBlDevScripterException >> gtInspectScripterFor: anAction [
	<gtAction>
	self scripter ifNil: [ ^ anAction empty ].
	^ anAction button
		icon: BrGlamorousVectorIcons inspect;
		label: 'Scripter';
		tooltip: 'Inspect Scripter';
		priority: 100;
		action: [ :aButton | aButton phlow spawnObject: self scripter ]
]

{ #category : #'*GToolkit-Extensions' }
TBlDevScripterException >> gtLiveFor: aView [
	<gtView>
	^ (super gtLiveFor: aView)
		priority: 2
]

{ #category : #'*GToolkit-Extensions' }
TBlDevScripterException >> gtMessageTextFor: aView [
	<gtView>
	self exception ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Message';
		priority: 1;
		object: [ self exception ];
		view: #gtMessageTextFor:
]

{ #category : #'*GToolkit-Extensions' }
TBlDevScripterException >> gtSpaceFor: aView [
	<gtView>
	self scripter ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Preview';
		priority: 5;
		object: [ self scripter ];
		view: #gtSpaceFor:
]

{ #category : #'*GToolkit-Extensions' }
TBlDevScripterException >> gtStepsMondrianTreeFor: aView [
	<gtView>
	self scripter ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Steps';
		priority: 7;
		object: [ self scripter ];
		view: #gtStepsMondrianTreeFor:
]

{ #category : #'*GToolkit-Extensions' }
TBlDevScripterException >> gtStepsTreeFor: aView [
	<gtView>
	self scripter ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Steps In Tree';
		priority: 9;
		object: [ self scripter ];
		view: #gtStepsTreeFor:
]
