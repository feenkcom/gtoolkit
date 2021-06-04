Class {
	#name : #GtProfilerProcessTelemetryViewModelStopped,
	#superclass : #Announcement,
	#instVars : [
		'profilerProcessTelemetryViewModel'
	],
	#category : #'GToolkit-Profiler-Process - Events'
}

{ #category : #generated }
GtProfilerProcessTelemetryViewModelStopped >> profilerProcessTelemetryViewModel [
	<objectGetter: #processTelemetry>
	<generatedFrom: #'GtRobocoderMetamodelAnnouncementTemplate>>#objectGetterTemplate'>

	^ profilerProcessTelemetryViewModel
]

{ #category : #generated }
GtProfilerProcessTelemetryViewModelStopped >> profilerProcessTelemetryViewModel: aProfilerProcessTelemetryViewModel [
	<objectSetter: #processTelemetry>
	<generatedFrom: #'GtRobocoderMetamodelAnnouncementTemplate>>#objectSetterTemplate'>

	profilerProcessTelemetryViewModel := aProfilerProcessTelemetryViewModel
]
