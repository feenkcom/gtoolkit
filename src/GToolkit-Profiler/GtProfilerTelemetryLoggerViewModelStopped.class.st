Class {
	#name : #GtProfilerTelemetryLoggerViewModelStopped,
	#superclass : #Announcement,
	#instVars : [
		'profilerTelemetryLoggerViewModel'
	],
	#category : #'GToolkit-Profiler-Process - Events'
}

{ #category : #generated }
GtProfilerTelemetryLoggerViewModelStopped >> profilerTelemetryLoggerViewModel [
	<objectGetter: #telemetryLogger>
	<generatedFrom: #'GtRobocoderMetamodelAnnouncementTemplate>>#objectGetterTemplate'>

	^ profilerTelemetryLoggerViewModel
]

{ #category : #generated }
GtProfilerTelemetryLoggerViewModelStopped >> profilerTelemetryLoggerViewModel: aProfilerTelemetryLoggerViewModel [
	<objectSetter: #telemetryLogger>
	<generatedFrom: #'GtRobocoderMetamodelAnnouncementTemplate>>#objectSetterTemplate'>

	profilerTelemetryLoggerViewModel := aProfilerTelemetryLoggerViewModel
]
