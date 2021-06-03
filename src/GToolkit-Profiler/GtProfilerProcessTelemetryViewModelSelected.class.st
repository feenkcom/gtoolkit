Class {
	#name : #GtProfilerProcessTelemetryViewModelSelected,
	#superclass : #Announcement,
	#instVars : [
		'profilerProcessTelemetryViewModel'
	],
	#category : #'GToolkit-Profiler-Process - Events'
}

{ #category : #generated }
GtProfilerProcessTelemetryViewModelSelected >> profilerProcessTelemetryViewModel [
	<objectGetter: #processTelemetry>
	<generatedFrom: #'GtRobocoderMetamodelAnnouncementTemplate>>#objectGetterTemplate'>

	^ profilerProcessTelemetryViewModel
]

{ #category : #generated }
GtProfilerProcessTelemetryViewModelSelected >> profilerProcessTelemetryViewModel: aProfilerProcessTelemetryViewModel [
	<objectSetter: #processTelemetry>
	<generatedFrom: #'GtRobocoderMetamodelAnnouncementTemplate>>#objectSetterTemplate'>

	profilerProcessTelemetryViewModel := aProfilerProcessTelemetryViewModel
]
