Class {
	#name : #GtProfilerProcessTelemetryListItemElement,
	#superclass : #BrHorizontalPane,
	#traits : 'TGtWithProfilerProcessTelemetryViewModel',
	#classTraits : 'TGtWithProfilerProcessTelemetryViewModel classTrait',
	#instVars : [
		'label',
		'status'
	],
	#category : #'GToolkit-Profiler-Process - Views'
}

{ #category : #initialization }
GtProfilerProcessTelemetryListItemElement >> initialize [
	super initialize.
	
	self addAptitude: BrGlamorousListItemAptitude.
	self hMatchParent.
	self vFitContent.
	self padding: (BlInsets all: 3).
	self cellSpacing: 10.
	self alignCenterLeft.
	
	status := BlElement new
		geometry: BlCircle new;
		size: 10@10.
	
	label := BrLabel new
		aptitude: BrGlamorousLabelAptitude.
	
	self addChild: status.
	self addChild: label.
	
	self when: BlClickEvent do: [ :anEvent |
		anEvent consumed: true.
		self profilerProcessTelemetryViewModel selectProcessTelemetryWithoutOtherEntities ]
]

{ #category : #'api - profiler process telemetry view model' }
GtProfilerProcessTelemetryListItemElement >> onProfilerProcessTelemetryViewModelChanged [
	"Is sent when a new profilerProcessTelemetryViewModel is assigned to the receiver.
	Note: #onProfilerProcessTelemetryViewModelChanged is sent before #subscribeToProfilerProcessTelemetryViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostProfilerProcessTelemetryViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
	
	label text: self profilerProcessTelemetryViewModel displayLabel.
	self updateStatus
]

{ #category : #'api - profiler process telemetry view model' }
GtProfilerProcessTelemetryListItemElement >> subscribeToProfilerProcessTelemetryViewModel [
	"Is sent after a new profilerProcessTelemetryViewModel is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromProfilerProcessTelemetryViewModel if the receiver subscribes to them"
	<modelSubscriber: #processTelemetry>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
	
	self profilerProcessTelemetryViewModel
		when: GtProfilerProcessTelemetryViewModelSelected, GtProfilerProcessTelemetryViewModelDeselected
			send: #updateSelection
			to: self.
			
	self profilerProcessTelemetryViewModel
		when: GtProfilerProcessTelemetryViewModelStarted, GtProfilerProcessTelemetryViewModelStopped
			send: #updateStatus
			to: self
]

{ #category : #'api - profiler process telemetry view model' }
GtProfilerProcessTelemetryListItemElement >> unsubscribeFromProfilerProcessTelemetryViewModel [
	"Is sent before a new profilerProcessTelemetryViewModel is assigned to the receiver.
	Objects that subscribe to profilerProcessTelemetryViewModel are required to implement this method."
	<modelUnsubscriber: #processTelemetry>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
	
	self profilerProcessTelemetryViewModel unsubscribe: self
]

{ #category : #'private - updating' }
GtProfilerProcessTelemetryListItemElement >> updateSelection [
	
	self profilerProcessTelemetryViewModel isOnlySelectedProcessTelemetry
		ifTrue: [ self states addState: BlElementState selected ]
		ifFalse: [ self states removeState: BlElementState selected ].
		
	self profilerProcessTelemetryViewModel isOnlySelectedProcessTelemetry
		ifTrue: [ self phlow spawnTool: (GtProfilerProcessTelemetryTool new profilerProcessTelemetryViewModel: self profilerProcessTelemetryViewModel) ]
]

{ #category : #'private - updating' }
GtProfilerProcessTelemetryListItemElement >> updateStatus [
	| aColor |

	aColor := self profilerProcessTelemetryViewModel isRunning
		ifTrue: [ self theme status successBackgroundColor ]
		ifFalse: [ self theme status neutralBackgroundColor ].
		
	status background: aColor
]
