Class {
	#name : #GtProfilerTelemetryLoggerViewModelStarted,
	#superclass : #Announcement,
	#instVars : [
		'profilerTelemetryLoggerViewModel'
	],
	#category : 'GToolkit-Profiler-Process - Events'
}

{ #category : #generated }
GtProfilerTelemetryLoggerViewModelStarted >> profilerTelemetryLoggerViewModel [
	<objectGetter: #telemetryLogger>
	<generatedFrom: #'GtRobocoderMetamodelAnnouncementTemplate>>#objectGetterTemplate'>

	^ profilerTelemetryLoggerViewModel
]

{ #category : #generated }
GtProfilerTelemetryLoggerViewModelStarted >> profilerTelemetryLoggerViewModel: aProfilerTelemetryLoggerViewModel [
	<objectSetter: #telemetryLogger>
	<generatedFrom: #'GtRobocoderMetamodelAnnouncementTemplate>>#objectSetterTemplate'>

	profilerTelemetryLoggerViewModel := aProfilerTelemetryLoggerViewModel
]
