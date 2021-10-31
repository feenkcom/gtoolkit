Class {
	#name : #GtProfilerProcessTelemetryModelStarted,
	#superclass : #Announcement,
	#instVars : [
		'profilerProcessTelemetryModel'
	],
	#category : 'GToolkit-Profiler-Process - Events'
}

{ #category : #accessing }
GtProfilerProcessTelemetryModelStarted >> profilerProcessTelemetryModel [
	^ profilerProcessTelemetryModel
]

{ #category : #accessing }
GtProfilerProcessTelemetryModelStarted >> profilerProcessTelemetryModel: anObject [
	profilerProcessTelemetryModel := anObject
]
