Class {
	#name : #GtMonitorGlutinEventsLogger,
	#superclass : #CircularMemoryLogger,
	#instVars : [
		'interestingEvents'
	],
	#category : #'GToolkit-Monitor-Glutin Events Logger'
}

{ #category : #initialize }
GtMonitorGlutinEventsLogger >> initialize [
	super initialize.
	
	interestingEvents := Set new
]

{ #category : #accessing }
GtMonitorGlutinEventsLogger >> interestingEvents [
	^ interestingEvents
]

{ #category : #accessing }
GtMonitorGlutinEventsLogger >> interestingEvents: anObject [
	interestingEvents := anObject asSet
]

{ #category : #accessing }
GtMonitorGlutinEventsLogger >> nextPut: aSignal [
	aSignal class == GlutinEventSignal
		ifFalse: [ ^ self ].

	(self interestingEvents includes: aSignal event class)
		ifFalse: [ ^ self ].

	super nextPut: aSignal copy
]
