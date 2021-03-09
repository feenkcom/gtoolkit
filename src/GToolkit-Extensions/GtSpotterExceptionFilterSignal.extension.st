Extension { #name : #GtSpotterExceptionFilterSignal }

{ #category : #'*GToolkit-Extensions' }
GtSpotterExceptionFilterSignal >> gtDebugActionFor: anAction [
	<gtAction>
	self exception ifNil: [ ^ anAction noAction ].
	^ self exception gtDebugActionFor: anAction
]

{ #category : #'*GToolkit-Extensions' }
GtSpotterExceptionFilterSignal >> gtStackFor: aView [
	<gtView>
	self exception ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Stack';
		priority: 20;
		object: [ self exception ];
		view: #gtLiveFor:;
		actionButtonIcon: BrGlamorousIcons inspect
			label: 'Exception' 
			tooltip: 'Inspect exception' 
			action: [ :aButton | aButton phlow spawnObject: self exception ]
]
