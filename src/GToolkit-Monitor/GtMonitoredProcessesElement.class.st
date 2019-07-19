Class {
	#name : #GtMonitoredProcessesElement,
	#superclass : #GtMonitoredServicesElement,
	#category : #'GToolkit-Monitor'
}

{ #category : #'instance creation' }
GtMonitoredProcessesElement class >> open [
	<script: 'self open'>
	| aSpace |
	
	aSpace := BlSpace new.
	aSpace title: 'Space Monitor'.
	aSpace addChild: (GtInspector createOn: self new).
	aSpace extent: 1280@800.
	aSpace show
]

{ #category : #initialization }
GtMonitoredProcessesElement >> initializeServiceListDefinition [

	servicesList column
		title: 'Priority';
		stencil: [ :aMonitoredService |
			| aPriority |
			
			aPriority := aMonitoredService priority.
			aPriority isZero 
				ifTrue: [ aPriority := aPriority asRopedText italic ]
				ifFalse: [ aPriority := aPriority asRopedText ].
			
			BrLabel new
				look: BrGlamorousLabelLook;
				text: aPriority;
				hExact: 30 ].
	
	servicesList column
		title: 'Processes';
		stencil: [ :aMonitoredService |
			| aTitle |
			
			aTitle := aMonitoredService title.
			aTitle isEmpty ifTrue: [ 
				aTitle := aMonitoredService processIdAndContext asRopedText foreground: Color gray ].
			aTitle isEmpty ifTrue: [ aTitle := '[No name]' asRopedText italic ].
			
			BrLabel new
				look: BrGlamorousLabelLook;
				text: aTitle;
				hMatchParent ].

	servicesList column
		title: 'State';
		stencil: [ :aMonitoredService |
			| isOpened |

			isOpened := aMonitoredService exists
				ifTrue: [ aMonitoredService isSuspended
					ifTrue: [ 'Suspended' asRopedText bold ]
					ifFalse: [ ' ' asRopedText ] ]
				ifFalse: [ '~Garbage collected~' asRopedText italic foreground: Color gray ].
			
			BrLabel new
				look: BrGlamorousLabelLook;
				text: isOpened;
				hExact: 100 ].
		
	self updateList
]

{ #category : #initialization }
GtMonitoredProcessesElement >> onClickTransformation [
	^ [ :aMonitoredService | aMonitoredService service ifNil: [ aMonitoredService ] ]
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
