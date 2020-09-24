Class {
	#name : #GtMonitor,
	#superclass : #Object,
	#category : #'GToolkit-Monitor'
}

{ #category : #accessing }
GtMonitor >> gtActionProfilerFor: anAction [
	<gtAction>
	^ anAction button 
		icon: BrGlamorousVectorIcons performance;
		priority: 1;
		tooltip: 'Profiler';
		action: [ GtProfiler open ]
]

{ #category : #'gt-extension' }
GtMonitor >> gtExternalResourcesFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'External resources';
		priority: 8;
		stencil: [ GtMonitoredExternalResourcesElement new ];
		actionStencil: [ :aTab |
			BrButton new 
				look: BrGlamorousButtonWithIconLook;
				icon: BrGlamorousIcons trash;
				label: 'Garbage collect';
				action:  [ Smalltalk garbageCollect ] ];
		actionStencil: [ :aTab |
			BrButton new 
				look: BrGlamorousButtonWithIconLook;
				icon: BrGlamorousVectorIcons refresh;
				label: 'Refresh';
				action:  [ aTab viewContentElement children first updateList ] ]
]

{ #category : #'gt-extension' }
GtMonitor >> gtGlutinEventFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Events';
		priority: 3;
		stencil: [ GtMonitorGlutinEventsElement new ]
]

{ #category : #accessing }
GtMonitor >> gtKeyboardFor: aView [
	<gtView>
	^ aView explicit
		title: 'Keyboard';
		priority: 3.1;
		stencil: [ BlDevKeyboard new asScalableElement ]
]

{ #category : #'gt-extension' }
GtMonitor >> gtLoggersFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Loggers';
		priority: 6;
		stencil: [ GtMonitoredSignalLoggersElement new ];
		actionStencil: [ 
			BrButton new 
				look: BrGlamorousButtonWithIconLook;
				icon: BrGlamorousIcons trash asElement;
				action:  [ :aButton |
					SignalLogger allSubInstances
						do: [ :eachLogger | eachLogger stop; reset ].
					Smalltalk garbageCollect ] ]
]

{ #category : #'gt-extension' }
GtMonitor >> gtMixedAnnouncersFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Mixed announcers';
		priority: 7;
		stencil: [ GtMonitoredMixedAnnouncersElement new ];
		actionStencil: [ :aTab |
			BrButton new 
				look: BrGlamorousButtonWithIconLook;
				icon: BrGlamorousIcons trash;
				label: 'Reset all';
				action:  [
					GtMonitoredMixedAnnouncersElement allMixedAnnouncers do: [ :each | each makeStrong; removeSubscriptions ].
					aTab viewContentElement children first updateList ] ];
		actionStencil: [ :aTab |
			BrButton new 
				look: BrGlamorousButtonWithIconLook;
				icon: [ BrGlamorousVectorIcons largeSignal asElement asScalableElement size: 16@16 ] asStencil;
				label: 'Make weak all';
				action:  [
					GtMonitoredMixedAnnouncersElement allMixedAnnouncers do: [ :each | each makeWeak ].
					aTab viewContentElement children first updateList ] ]
]

{ #category : #'gt-extension' }
GtMonitor >> gtProcessesFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Processes';
		priority: 5;
		stencil: [ GtMonitoredProcessesElement new ]
]

{ #category : #'gt-extension' }
GtMonitor >> gtSpaceRunnerFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Space runner';
		priority: 20;
		stencil: [ GtMonitorSpaceRunner new ]
]

{ #category : #'gt-extension' }
GtMonitor >> gtSpacesFor: aView [
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
GtMonitor >> gtSystemInfoFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'System';
		priority: 1;
		stencil: [ GtMonitorSystemInfoElement new ]
]

{ #category : #'gt-extension' }
GtMonitor >> gtTaskItServicesFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Services';
		priority: 4;
		tooltip: 'TaskIt Services';
		stencil: [ GtMonitoredTaskItServicesElement new ];
		actionButtonIcon: BrGlamorousIcons trash 
			tooltip: 'Remove not running services'
			action: [ :aButton | TKTConfiguration serviceManager purge ]
]

{ #category : #'gt-extension' }
GtMonitor >> gtUniversesFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Universes';
		priority: 2;
		stencil: [ GtMonitoredUniversesElement new ]
]
