Class {
	#name : #GtMonitoredTaskItServicesElement,
	#superclass : #GtMonitoredServicesElement,
	#category : #'GToolkit-Monitor'
}

{ #category : #'instance creation' }
GtMonitoredTaskItServicesElement class >> open [
	<script: 'self open'>
	| aSpace |
	
	aSpace := BlSpace new.
	aSpace title: 'Space Monitor'.
	aSpace addChild: (GtInspector createOn: self new).
	aSpace extent: 1280@800.
	aSpace show
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
