Class {
	#name : #GtProfilerTelemetryLoggerElement,
	#superclass : #BrVerticalPane,
	#traits : 'TGtWithProfilerTelemetryLoggerViewModel',
	#classTraits : 'TGtWithProfilerTelemetryLoggerViewModel classTrait',
	#category : 'GToolkit-Profiler-Process - Views'
}

{ #category : #initialization }
GtProfilerTelemetryLoggerElement >> initialize [
	super initialize
]

{ #category : #'api - profiler telemetry logger view model' }
GtProfilerTelemetryLoggerElement >> onProfilerTelemetryLoggerViewModelChanged [
	"Is sent when a new profilerTelemetryLoggerViewModel is assigned to the receiver.
	Note: #onProfilerTelemetryLoggerViewModelChanged is sent before #subscribeToProfilerTelemetryLoggerViewModel
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostProfilerTelemetryLoggerViewModelChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
	| contentViews contentTabs |

	self removeChildren.

	contentViews := GtPhlowViewsCollector new
		fromObject: self profilerTelemetryLoggerViewModel;
		pragmaName: #gtProfilerTelemetryLoggerView;
		collect.

	contentTabs := GtPhlowCompositeView new
		views: contentViews;
		asElementDo: [ :aBrTabGroup | aBrTabGroup ].

	self addChild: contentTabs

	
]
