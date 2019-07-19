Class {
	#name : #GtMonitoredBlocSpaces,
	#superclass : #Object,
	#category : #'GToolkit-Monitor'
}

{ #category : #'gt-extension' }
GtMonitoredBlocSpaces >> gtServicesFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Services';
		priority: 2;
		stencil: [ GtMonitoredTaskItServicesElement new ]
]

{ #category : #'gt-extension' }
GtMonitoredBlocSpaces >> gtSpacesFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Spaces';
		priority: 1;
		stencil: [ GtMonitoredBlocSpacesElement new ];
		actionStencil: [ 
			BrButton new 
				look: BrGlamorousButtonWithIconLook;
				icon: BrGlamorousIcons trash asElement;
				action:  [ :aButton |
					(BlSpace allSubInstances copyWithout: aButton space) do: [ :eachSpace |
						eachSpace isOpened
							ifTrue: [ eachSpace close ] ].
					Smalltalk garbageCollect ] ]
]
