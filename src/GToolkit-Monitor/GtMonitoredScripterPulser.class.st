Class {
	#name : #GtMonitoredScripterPulser,
	#superclass : #Object,
	#instVars : [
		'pulser'
	],
	#category : #'GToolkit-Monitor-Scripter'
}

{ #category : #accessing }
GtMonitoredScripterPulser >> pulser [
	<return: #BlDevScripterPulseUntilReady or: nil>
	^ pulser at: 1
]

{ #category : #accessing }
GtMonitoredScripterPulser >> pulser: aBlDevScripterPulseUntilReady [
	pulser := aBlDevScripterPulseUntilReady asWeakReference
]

{ #category : #accessing }
GtMonitoredScripterPulser >> status [
	<return: #BlText>
	| aPulser |
	
	aPulser := self pulser ifNil: [ ^ '' ].
	
	aPulser hasFinished ifTrue: [ 
		^ 'finished' asRopedText foreground: BrGlamorousColors disabledButtonTextColor ].

	aPulser hasStarted ifFalse: [ 
		^ 'not started' asRopedText foreground: BrGlamorousColors disabledButtonTextColor ].
	
	aPulser elapsedTime ifNotNil: [ :aDuration |
		| aText |
		aText := aDuration gtHumanReadableString asRopedText.
		aPulser isLikelyLockedUp
			ifTrue: [ aText foreground: BrGlamorousColors errorBackgroundColor ]
			ifFalse: [ aText foreground: BrGlamorousColors failureBackgroundColor ] ].
	
	^ 'running' asRopedText foreground: BrGlamorousColors failureBackgroundColor
]

{ #category : #accessing }
GtMonitoredScripterPulser >> title [
	<return: #BlText>
	| aPulser |
	
	aPulser := self pulser ifNil: [ ^ '' ].
	
	^ aPulser stepDefiningMethod asString
]
