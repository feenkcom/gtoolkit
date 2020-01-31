Class {
	#name : #GtMonitoredBlocSpaces,
	#superclass : #Object,
	#category : #'GToolkit-Monitor'
}

{ #category : #'gt-extension' }
GtMonitoredBlocSpaces >> gtProcessesFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Processes';
		priority: 4;
		stencil: [ GtMonitoredProcessesElement new ]
]

{ #category : #'gt-extension' }
GtMonitoredBlocSpaces >> gtSpacesFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Spaces';
		priority: 2;
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

{ #category : #'gt-extension' }
GtMonitoredBlocSpaces >> gtTaskItServicesFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Services';
		priority: 3;
		stencil: [ GtMonitoredTaskItServicesElement new ];
		actionButtonIcon: BrGlamorousIcons trash 
			action: [ :aButton | TKTConfiguration serviceManager purge ]
			
]

{ #category : #'gt-extension' }
GtMonitoredBlocSpaces >> gtUniversesFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Universes';
		priority: 1;
		stencil: [ GtMonitoredUniversesElement new ]
]
