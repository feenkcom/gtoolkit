Class {
	#name : #GtProfilerProcessTelemetryModelRemovedAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'profilerProcessTelemetryModel'
	],
	#category : #'GToolkit-Profiler-Process - Events'
}

{ #category : #generated }
GtProfilerProcessTelemetryModelRemovedAnnouncement >> profilerProcessTelemetryModel [
	<objectGetter: #processTelemetry>
	<generatedFrom: #'GtRobocoderMetamodelAnnouncementTemplate>>#objectGetterTemplate'>

	^ profilerProcessTelemetryModel
]

{ #category : #generated }
GtProfilerProcessTelemetryModelRemovedAnnouncement >> profilerProcessTelemetryModel: aProfilerProcessTelemetryModel [
	<objectSetter: #processTelemetry>
	<generatedFrom: #'GtRobocoderMetamodelAnnouncementTemplate>>#objectSetterTemplate'>

	profilerProcessTelemetryModel := aProfilerProcessTelemetryModel
]
