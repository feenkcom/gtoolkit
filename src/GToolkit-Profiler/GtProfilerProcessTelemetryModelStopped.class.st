Class {
	#name : #GtProfilerProcessTelemetryModelStopped,
	#superclass : #Announcement,
	#instVars : [
		'profilerProcessTelemetryModel'
	],
	#category : 'GToolkit-Profiler-Process - Events'
}

{ #category : #accessing }
GtProfilerProcessTelemetryModelStopped >> profilerProcessTelemetryModel [
	^ profilerProcessTelemetryModel
]

{ #category : #accessing }
GtProfilerProcessTelemetryModelStopped >> profilerProcessTelemetryModel: anObject [
	profilerProcessTelemetryModel := anObject
]
