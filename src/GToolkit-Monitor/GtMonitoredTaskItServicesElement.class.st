Class {
	#name : #GtMonitoredTaskItServicesElement,
	#superclass : #GtMonitoredServicesElement,
	#category : #'GToolkit-Monitor'
}

{ #category : #'instance creation' }
GtMonitoredTaskItServicesElement class >> open [
	<script: 'self open'>
	Gt2Inspector openOn: self new
]

{ #category : #initialization }
GtMonitoredTaskItServicesElement >> initializeServiceListDefinition [

	servicesList column
		title: 'Service';
		stencil: [ :aMonitoredService |
			| aTitle |
			
			aTitle := aMonitoredService title.
			aTitle ifEmpty: [ aTitle := '[No name]' asRopedText italic ].
			
			BrLabel new
				look: BrGlamorousLabelLook;
				text: aTitle;
				hMatchParent ].

	servicesList column
		title: 'Running';
		stencil: [ :aMonitoredService |
			| isOpened |

			isOpened := aMonitoredService exists
				ifTrue: [ aMonitoredService isRunning
					ifTrue: [ 'Running' asRopedText bold ]
					ifFalse: [ 'Inactive' asRopedText ] ]
				ifFalse: [ '~Garbage collected~' asRopedText italic foreground: Color gray ].
			
			BrLabel new
				look: BrGlamorousLabelLook;
				text: isOpened;
				hExact: 100 ].
			
	servicesList column
		title: 'Queue';
		stencil: [ :aMonitoredService |
			| aQueueSize |
			aQueueSize := aMonitoredService queueSize.
			aQueueSize := aQueueSize isZero 
				ifTrue: [ '0' asRopedText foreground: Color gray ]
				ifFalse: [ aQueueSize asString asRopedText ].
			
			BrLabel new
				look: BrGlamorousLabelLook;
				text: aQueueSize;
				hExact: 100 ].
			
	servicesList column
		title: 'Errors';
		stencil: [ :aMonitoredService |
			| aNumberOfFailedTasks |
			aNumberOfFailedTasks := aMonitoredService numberOfFailedTasks.
			aNumberOfFailedTasks := aNumberOfFailedTasks isZero 
				ifTrue: [ '' asRopedText ]
				ifFalse: [ 
					(aNumberOfFailedTasks asString, 
						(' failure' asPluralBasedOn: aNumberOfFailedTasks))
					 		asRopedText foreground: Color red ].
			
			BrLabel new
				look: BrGlamorousLabelLook;
				text: aNumberOfFailedTasks;
				hExact: 100 ].
]

{ #category : #initialization }
GtMonitoredTaskItServicesElement >> onClickTransformation [
	^ [ :aMonitoredService | aMonitoredService service ifNil: [ aMonitoredService ] ]
]

{ #category : #updating }
GtMonitoredTaskItServicesElement >> retreiveNewServiceList [
	| allServices |
	allServices := TKTConfiguration serviceManager services copy.
	allServices := allServices collect: [ :eachService | GtMonitoredTaskItService new service: eachService ].
	allServices := allServices sorted: [ :a :b | a title < b title ].
	^ allServices 
]

{ #category : #updating }
GtMonitoredTaskItServicesElement >> updateTaskName [
	^ '[Monitor] TaskIt Services Update Task'
]
