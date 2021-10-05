Extension { #name : #AsyncPollReady }

{ #category : #'*GToolkit-Extensions' }
AsyncPollReady >> gtValueFor: aView [

	<gtView>
	^ aView forward
		  title: 'Value';
		  object: [ self value ];
		  view: #gtLiveFor:;
		  actionButtonIcon: BrGlamorousVectorIcons inspect
		  tooltip: 'Inspect value'
		  action: [ :aButton | aButton phlow spawnObject: self value ]
]
