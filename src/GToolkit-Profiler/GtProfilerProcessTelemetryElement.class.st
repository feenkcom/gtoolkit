Class {
	#name : #GtProfilerProcessTelemetryElement,
	#superclass : #BrVerticalPane,
	#traits : 'TGtWithProfilerProcessTelemetryViewModel',
	#classTraits : 'TGtWithProfilerProcessTelemetryViewModel classTrait',
	#instVars : [
		'telemetryLogger',
		'toolbar',
		'startButton',
		'stopButton',
		'resetButton',
		'description'
	],
	#category : #'GToolkit-Profiler-Process - Views'
}

{ #category : #initialization }
GtProfilerProcessTelemetryElement >> initialize [
	super initialize.
	
	self matchParent.
	self alignTopCenter.
	
	description := BrEditor new
		beReadOnlyWithSelection;
		vFitContent;
		hMatchParent;
		padding: (BlInsets all: 10);
		aptitude: BrGlamorousRegularEditorAptitude.
	
	toolbar := BrToolbar new
		aptitude: BrGlamorousToolbarAptitude new.
	
	startButton := BrButton new
		disable;
		aptitude: BrGlamorousButtonWithLabelAptitude new;
		beSmallSize;
		label: 'Start';
		action: [ :aButton | self profilerProcessTelemetryViewModel start ].

	stopButton := BrButton new
		disable;
		beSmallSize;
		aptitude: BrGlamorousButtonWithLabelAptitude new;
		label: 'Stop';
		action: [ self profilerProcessTelemetryViewModel stop ].

	resetButton := BrButton new
		disable;
		aptitude: BrGlamorousButtonWithLabelAptitude new;
		beSmallSize;
		label: 'Reset';
		action: [ self profilerProcessTelemetryViewModel reset ].

	toolbar addItems: { startButton . stopButton . resetButton }.
	
	telemetryLogger := GtProfilerTelemetryLoggerElement new.
	telemetryLogger matchParent.
	
	self addChildren: { description . toolbar . telemetryLogger }
]

{ #category : #'api - profiler process telemetry view model' }
GtProfilerProcessTelemetryElement >> onProfilerProcessTelemetryViewModelChanged [
	"Is sent when a new profilerProcessTelemetryViewModel is assigned to the receiver.
	Note: #onProfilerProcessTelemetryViewModelChanged is sent before #subscribeToProfilerProcessTelemetryViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostProfilerProcessTelemetryViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
	
	self updateDescriptionText.
	self updateToolbarButtons.
	telemetryLogger profilerTelemetryLoggerViewModel: self profilerProcessTelemetryViewModel profilerTelemetryLoggerViewModel
]

{ #category : #'api - profiler process telemetry view model' }
GtProfilerProcessTelemetryElement >> subscribeToProfilerProcessTelemetryViewModel [
	"Is sent after a new profilerProcessTelemetryViewModel is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromProfilerProcessTelemetryViewModel if the receiver subscribes to them"
	<modelSubscriber: #processTelemetry>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
	
	self profilerProcessTelemetryViewModel
		when: GtProfilerProcessTelemetryViewModelStarted, GtProfilerProcessTelemetryViewModelStopped
		send: #updateToolbarButtons
		to: self
]

{ #category : #'api - profiler process telemetry view model' }
GtProfilerProcessTelemetryElement >> unsubscribeFromProfilerProcessTelemetryViewModel [
	"Is sent before a new profilerProcessTelemetryViewModel is assigned to the receiver.
	Objects that subscribe to profilerProcessTelemetryViewModel are required to implement this method."
	<modelUnsubscriber: #processTelemetry>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
	
	self profilerProcessTelemetryViewModel unsubscribe: self
]

{ #category : #'private - updating' }
GtProfilerProcessTelemetryElement >> updateDescriptionText [
	| aText |
	
	aText := 'Telemetry' asRopedText fontSize: 1.5 fontEm; bold.
	aText append: ((String cr, ' ', String cr) asRopedText fontSize: 0.5 fontEm).
	aText append: 'This is a process (thread) telemetry tool to collect performance measurements for ' asRopedText.
	aText append: (self profilerProcessTelemetryViewModel processTelemetryClass name asRopedText attribute: (GtButtonAttribute new
		beReplace;
		stencil: (GtButtonStencilBuilder new
			label: self profilerProcessTelemetryViewModel processTelemetryClass name;
			icon: BrGlamorousVectorIcons browse;
			action: [ self phlow spawnTool: (GtClassCoderTool forClass: self profilerProcessTelemetryViewModel processTelemetryClass) ]))).

	aText append: '. ' asRopedText.
	aText append: String cr asRopedText.
	aText append: 'Press ' asRopedText.
	aText append: 'start' asRopedText glamorousRoundedBackground.
	aText append: ' to beging recording the relevant telemetry and ' asRopedText.
	aText append: 'stop' asRopedText glamorousRoundedBackground.
	aText append: ' to finish. Do not forget to stop recording once you are done, otherwise it may affect the overall system performance and memory consuption.' asRopedText.

	description text: aText
]

{ #category : #'private - updating' }
GtProfilerProcessTelemetryElement >> updateToolbarButtons [
	startButton enabled: self profilerProcessTelemetryViewModel isRunning not.
	stopButton enabled: self profilerProcessTelemetryViewModel isRunning.
	resetButton enabled: true.
]
