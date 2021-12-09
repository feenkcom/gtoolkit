Extension { #name : #RGPackage }

{ #category : #'*GToolkit-Extensions' }
RGPackage >> gtBehaviorsFor: aView [
	<gtView>
	
	^ aView list
		title: 'Behaviors';
		priority: 10;
		items: [ self definedBehaviors ]
]
