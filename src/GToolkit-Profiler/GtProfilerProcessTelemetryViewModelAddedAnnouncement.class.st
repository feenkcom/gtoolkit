Class {
	#name : 'GtProfilerProcessTelemetryViewModelAddedAnnouncement',
	#superclass : 'Announcement',
	#instVars : [
		'profilerProcessTelemetryViewModel'
	],
	#category : 'GToolkit-Profiler-Process - Events'
}

{ #category : 'generated' }
GtProfilerProcessTelemetryViewModelAddedAnnouncement >> profilerProcessTelemetryViewModel [
	<objectGetter: #processTelemetry>
	<generatedFrom: #'GtRobocoderMetamodelAnnouncementTemplate>>#objectGetterTemplate'>

	^ profilerProcessTelemetryViewModel
]

{ #category : 'generated' }
GtProfilerProcessTelemetryViewModelAddedAnnouncement >> profilerProcessTelemetryViewModel: aProfilerProcessTelemetryViewModel [
	<objectSetter: #processTelemetry>
	<generatedFrom: #'GtRobocoderMetamodelAnnouncementTemplate>>#objectSetterTemplate'>

	profilerProcessTelemetryViewModel := aProfilerProcessTelemetryViewModel
]
