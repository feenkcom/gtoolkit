Class {
	#name : #GtDebuggerOnRopeSlide,
	#superclass : #GtSlide,
	#category : #'GToolkit-Scenery'
}

{ #category : #accessing }
GtDebuggerOnRopeSlide >> create [
	| process context debuggingSession |
	context := [ BlAttributeRopeExamples new small_delete_1_to_3 ] asContext.
	process := Process
		forContext: context
		priority: Processor userInterruptPriority.	
	debuggingSession := (process 
		newDebugSessionNamed: 'test debugging'
		startedAt: process suspendedContext).
	6 timesRepeat: [ 
		debuggingSession stepInto ].
	^ (GtExpandableDebuggerElement on: debuggingSession) inInspector
]
