Class {
	#name : 'GtProfilerProcessTelemetriesElement',
	#superclass : 'BrVerticalPane',
	#traits : 'TGtWithProfilerProcessTelemetriesViewModel',
	#classTraits : 'TGtWithProfilerProcessTelemetriesViewModel classTrait',
	#instVars : [
		'telemetries',
		'description'
	],
	#category : 'GToolkit-Profiler-Process - Views'
}

{ #category : 'initialization' }
GtProfilerProcessTelemetriesElement >> createDescriptionText [
	| aText |
	
	aText := 'Process telemetries' asRopedText fontSize: 1.5 fontEm; bold.
	aText append: ((String cr, ' ', String cr) asRopedText fontSize: 0.5 fontEm).
	aText append: 'Welcome to the process telemetries tool. Here you can find a list of all available types.' asRopedText.
	aText append: String cr asRopedText.
	aText append: 'To create a new type of telemetry simply make a new empty subclass of ' asRopedText.
	
	aText append: (BlProcessTelemetry name asRopedText attribute: (GtButtonAttribute new
		beReplace;
		stencil: (GtButtonStencilBuilder new
			label: BlProcessTelemetry name;
			icon: BrGlamorousVectorIcons browse;
			action: [ self phlow spawnTool: (GtClassCoderTool forClass: BlProcessTelemetry) ]))).
	
	aText append: '.' asRopedText.
	
	^ aText
]

{ #category : 'initialization' }
GtProfilerProcessTelemetriesElement >> initialize [
	super initialize.
	
	self matchParent.
	
	description := BrEditor new
		beReadOnlyWithSelection;
		vFitContent;
		hMatchParent;
		padding: (BlInsets all: 10);
		aptitude: BrGlamorousRegularEditorAptitude;
		text: self createDescriptionText.
	
	self addChild: description.
	
	telemetries := BrSimpleTree new
		withoutSelection;
		rowStencil: [ :aNodedType :aNodeElement | aNodeElement ];
		nodeStencil: [ GtProfilerProcessTelemetryListItemElement new ];
		nodeDataBinder: [ :eachElement :eachTelemetryViewModel |
			eachElement profilerProcessTelemetryViewModel: eachTelemetryViewModel ].
	
	(GtPhlowCompositeView new
		views: { GtPhlowExplicitView new title: 'Telemetries'; stencil: [ telemetries ]  };
		asElementDo: [ :aTabGroup | self addChild: aTabGroup ])
]

{ #category : 'api - profiler process telemetries view model' }
GtProfilerProcessTelemetriesElement >> onProfilerProcessTelemetriesViewModelChanged [
	"Is sent when a new profilerProcessTelemetriesViewModel is assigned to the receiver.
	Note: #onProfilerProcessTelemetriesViewModelChanged is sent before #subscribeToProfilerProcessTelemetriesViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostProfilerProcessTelemetriesViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
	
	telemetries items: self profilerProcessTelemetriesViewModel profilerProcessTelemetryViewModels immediate: [ :eachNode | #() ]
]
