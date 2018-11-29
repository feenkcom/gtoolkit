Class {
	#name : #GtSceneryDebuggerOnDocumenter,
	#superclass : #GtScenery,
	#category : #'GToolkit-Scenery'
}

{ #category : #'world menu' }
GtSceneryDebuggerOnDocumenter class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 600.0; 
		parent: #GToolkitScenery;
		label: 'Debugger: on documenter object';
		action: [self new setUp]
]

{ #category : #initialization }
GtSceneryDebuggerOnDocumenter >> setUp [
	| aBook aDocumentConstructor |
	aBook := GtPlayBook newDefault.
	aDocumentConstructor := Gt2Document name.
	aBook pages first snippets first sourceCode: 'process ifNotNil: [process terminate].
document := ', aDocumentConstructor, ' new text: ''!This is a debugging example''.
context := [ document printString ] asContext.
process := Process
	forContext: context
	priority: Processor userInterruptPriority.	
debuggingSession := (process 
	newDebugSessionNamed: ''test debugging'' 
	startedAt: process suspendedContext).
20 timesRepeat: [ 
	debuggingSession stepInto ].
GtExpandableDebugger openInspectorOn: debuggingSession.'.
	
	GtInspector openOnPlayBook: aBook
]
