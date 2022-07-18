Class {
	#name : #GtMonitoredProcessesElement,
	#superclass : #GtMonitoredServicesElement,
	#category : #'GToolkit-Monitor'
}

{ #category : #'instance creation' }
GtMonitoredProcessesElement class >> open [
	<script: 'self open'>
	GtInspector openOn: self new
]

{ #category : #initialization }
GtMonitoredProcessesElement >> initializeServiceListDefinition [

	servicesList column
		title: 'Priority';
		width: 30;
		stencil: [ :aMonitoredService |
			| aPriority |
			
			aPriority := aMonitoredService priority.
			aPriority isZero 
				ifTrue: [ aPriority := aPriority asRopedText italic ]
				ifFalse: [ aPriority := aPriority asRopedText ].
			
			BrLabel new
				aptitude: BrGlamorousLabelAptitude;
				text: aPriority;
				fitContent ].
	
	servicesList column
		title: 'Processes';
		weight: 1;
		stencil: [ :aMonitoredService |
			| aTitle |
			
			aTitle := aMonitoredService title.
			aTitle isEmpty ifTrue: [ 
				aTitle := aMonitoredService processIdAndContext asRopedText foreground: Color gray ].
			aTitle isEmpty ifTrue: [ aTitle := '[No name]' asRopedText italic ].
			
			BrLabel new
				aptitude: BrGlamorousLabelAptitude;
				text: aTitle;
				fitContent ].

	servicesList column
		title: 'State';
		width: 100;
		stencil: [ :aMonitoredService |
			| isOpened |

			isOpened := aMonitoredService exists
				ifTrue: [ aMonitoredService isSuspended
					ifTrue: [ 'Suspended' asRopedText bold ]
					ifFalse: [ ' ' asRopedText ] ]
				ifFalse: [ '~Garbage collected~' asRopedText italic foreground: Color gray ].
			
			BrLabel new
				aptitude: BrGlamorousLabelAptitude;
				text: isOpened;
				fitContent ].
			
	servicesList column
		title: 'Inspect';
		width: 30;
		stencil: [ :aMonitoredService |
			| aReifiedProcess |

			aReifiedProcess := aMonitoredService service
				ifNotNil: [ :aProcess |
					AsyncProcessProperties
						reifiedProcess: aProcess
						ifAbsent: [ nil ] ].

			BrButton new
				beSmallSize;
				visibility: (aReifiedProcess ifNil: [ BlVisibility gone ] ifNotNil: [ BlVisibility visible ]);
				aptitude: BrGlamorousButtonWithIconAptitude;
				icon: BrGlamorousVectorIcons inspect;
				label: 'Inspect reified process';
				action: [ :aButton | aButton phlow spawnObject: aReifiedProcess objectOfInterest ] ].
	
	self updateList
]

{ #category : #initialization }
GtMonitoredProcessesElement >> onClickTransformation [
	^ [ :aMonitoredService | aMonitoredService "service ifNil: [ aMonitoredService ]" ]
]

{ #category : #updating }
GtMonitoredProcessesElement >> retreiveNewServiceList [
	| allServices |
	allServices := Process allSubInstances reject: [:each | each isTerminated].
	allServices sort: [:a :b | a priority >= b priority].
	allServices := allServices collect: [ :eachService | GtMonitoredProcess new service: eachService ].
	^ allServices 
]

{ #category : #updating }
GtMonitoredProcessesElement >> updateTaskName [
	^ '[Monitor] TaskIt Services Update Task'
]
