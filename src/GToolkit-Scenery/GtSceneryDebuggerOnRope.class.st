Class {
	#name : #GtSceneryDebuggerOnRope,
	#superclass : #GtScenery,
	#category : #'GToolkit-Scenery'
}

{ #category : #'world menu' }
GtSceneryDebuggerOnRope class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 600.0; 
		parent: #GToolkitScenery;
		label: 'Debugger: on rope';
		action: [self new setUp]
]

{ #category : #initialization }
GtSceneryDebuggerOnRope >> setUp [
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
	GtExpandableDebuggerElement openInspectorOn: debuggingSession.
]
