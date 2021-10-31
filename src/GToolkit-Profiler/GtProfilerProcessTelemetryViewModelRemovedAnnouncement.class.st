Class {
	#name : #GtProfilerProcessTelemetryViewModelRemovedAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'profilerProcessTelemetryViewModel'
	],
	#category : 'GToolkit-Profiler-Process - Events'
}

{ #category : #generated }
GtProfilerProcessTelemetryViewModelRemovedAnnouncement >> profilerProcessTelemetryViewModel [
	<objectGetter: #processTelemetry>
	<generatedFrom: #'GtRobocoderMetamodelAnnouncementTemplate>>#objectGetterTemplate'>

	^ profilerProcessTelemetryViewModel
]

{ #category : #generated }
GtProfilerProcessTelemetryViewModelRemovedAnnouncement >> profilerProcessTelemetryViewModel: aProfilerProcessTelemetryViewModel [
	<objectSetter: #processTelemetry>
	<generatedFrom: #'GtRobocoderMetamodelAnnouncementTemplate>>#objectSetterTemplate'>

	profilerProcessTelemetryViewModel := aProfilerProcessTelemetryViewModel
]
