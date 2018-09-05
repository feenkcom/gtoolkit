Class {
	#name : #GtSceneryDebuggerOnDocumenter,
	#superclass : #GtScenery,
	#category : #'GToolkit-Scenery'
}

{ #category : #'world menu' }
GtSceneryDebuggerOnDocumenter class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 500.0; 
		parent: #GToolkitScenery;
		label: 'Debugger: on documenter object';
		action: [self new setUp]
]

{ #category : #initialization }
GtSceneryDebuggerOnDocumenter >> setUp [
	| book |
	book := GtPlayBook new.
	book pages first snippets first sourceCode: 'process ifNotNil: [process terminate].
document := GtDocumenter editorForText: ''!This is a debugging example''.
context := [ document printString ] asContext.
process := Process
	forContext: context
	priority: Processor userInterruptPriority.	
debuggingSession := (process 
	newDebugSessionNamed: ''test debugging'' 
	startedAt: process suspendedContext).
20 timesRepeat: [ 
	debuggingSession stepInto ].
GtDebugger openInspectorOn: debuggingSession.'.
	
	GtInspector openOnPlayBook: book
]
