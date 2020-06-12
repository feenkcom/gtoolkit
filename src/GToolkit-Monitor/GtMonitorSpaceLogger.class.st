"
I log space and universe related events
"
Class {
	#name : #GtMonitorSpaceLogger,
	#superclass : #MemoryLogger,
	#category : #'GToolkit-Monitor-Space Runner'
}

{ #category : #initialization }
GtMonitorSpaceLogger >> interestingSignals [
	^ { BlParallelUniverseSignal }
]

{ #category : #accessing }
GtMonitorSpaceLogger >> nextPut: aSignal [
	(self interestingSignals anySatisfy: [ :eachSignalClass |
		aSignal class == eachSignalClass or: [ aSignal class inheritsFrom: eachSignalClass ] ])
			ifFalse: [ ^ self ].

	super nextPut: aSignal
]
