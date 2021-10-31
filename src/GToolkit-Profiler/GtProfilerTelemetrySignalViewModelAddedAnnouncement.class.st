Class {
	#name : #GtProfilerTelemetrySignalViewModelAddedAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'profilerTelemetrySignalViewModel'
	],
	#category : 'GToolkit-Profiler-Process - Events'
}

{ #category : #generated }
GtProfilerTelemetrySignalViewModelAddedAnnouncement >> profilerTelemetrySignalViewModel [
	<objectGetter: #telemetrySignal>
	<generatedFrom: #'GtRobocoderMetamodelAnnouncementTemplate>>#objectGetterTemplate'>

	^ profilerTelemetrySignalViewModel
]

{ #category : #generated }
GtProfilerTelemetrySignalViewModelAddedAnnouncement >> profilerTelemetrySignalViewModel: aProfilerTelemetrySignalViewModel [
	<objectSetter: #telemetrySignal>
	<generatedFrom: #'GtRobocoderMetamodelAnnouncementTemplate>>#objectSetterTemplate'>

	profilerTelemetrySignalViewModel := aProfilerTelemetrySignalViewModel
]
