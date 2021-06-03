Class {
	#name : #GtProfilerProcessTelemetryModelAddedAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'profilerProcessTelemetryModel'
	],
	#category : #'GToolkit-Profiler-Process - Events'
}

{ #category : #generated }
GtProfilerProcessTelemetryModelAddedAnnouncement >> profilerProcessTelemetryModel [
	<objectGetter: #processTelemetry>
	<generatedFrom: #'GtRobocoderMetamodelAnnouncementTemplate>>#objectGetterTemplate'>

	^ profilerProcessTelemetryModel
]

{ #category : #generated }
GtProfilerProcessTelemetryModelAddedAnnouncement >> profilerProcessTelemetryModel: aProfilerProcessTelemetryModel [
	<objectSetter: #processTelemetry>
	<generatedFrom: #'GtRobocoderMetamodelAnnouncementTemplate>>#objectSetterTemplate'>

	profilerProcessTelemetryModel := aProfilerProcessTelemetryModel
]
