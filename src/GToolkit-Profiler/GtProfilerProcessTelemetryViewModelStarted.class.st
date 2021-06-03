Class {
	#name : #GtProfilerProcessTelemetryViewModelStarted,
	#superclass : #Announcement,
	#instVars : [
		'profilerProcessTelemetryViewModel'
	],
	#category : #'GToolkit-Profiler-Process - Events'
}

{ #category : #generated }
GtProfilerProcessTelemetryViewModelStarted >> profilerProcessTelemetryViewModel [
	<objectGetter: #processTelemetry>
	<generatedFrom: #'GtRobocoderMetamodelAnnouncementTemplate>>#objectGetterTemplate'>

	^ profilerProcessTelemetryViewModel
]

{ #category : #generated }
GtProfilerProcessTelemetryViewModelStarted >> profilerProcessTelemetryViewModel: aProfilerProcessTelemetryViewModel [
	<objectSetter: #processTelemetry>
	<generatedFrom: #'GtRobocoderMetamodelAnnouncementTemplate>>#objectSetterTemplate'>

	profilerProcessTelemetryViewModel := aProfilerProcessTelemetryViewModel
]
