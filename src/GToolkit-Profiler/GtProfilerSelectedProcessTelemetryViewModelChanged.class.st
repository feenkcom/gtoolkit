Class {
	#name : #GtProfilerSelectedProcessTelemetryViewModelChanged,
	#superclass : #Announcement,
	#instVars : [
		'selectedProcessTelemetryViewModel'
	],
	#category : #'GToolkit-Profiler-Process - Events'
}

{ #category : #generated }
GtProfilerSelectedProcessTelemetryViewModelChanged >> selectedProcessTelemetryViewModel [
	<objectGetter: #processTelemetry>
	<generatedFrom: #'GtRobocoderMetamodelAnnouncementTemplate>>#objectGetterTemplate'>

	^ selectedProcessTelemetryViewModel
]

{ #category : #generated }
GtProfilerSelectedProcessTelemetryViewModelChanged >> selectedProcessTelemetryViewModel: aSelectedProcessTelemetryViewModel [
	<objectSetter: #processTelemetry>
	<generatedFrom: #'GtRobocoderMetamodelAnnouncementTemplate>>#objectSetterTemplate'>

	selectedProcessTelemetryViewModel := aSelectedProcessTelemetryViewModel
]
