Class {
	#name : #GtSceneryDebuggerDocumentWithExceptionInExample,
	#superclass : #GtScenery,
	#category : #'GToolkit-Scenery'
}

{ #category : #'world menu' }
GtSceneryDebuggerDocumentWithExceptionInExample class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 601.0; 
		parent: #GToolkitScenery;
		label: 'Debugger: on documenter with exception in example';
		action: [self new setUp];
		withSeparatorAfter
]

{ #category : #initialization }
GtSceneryDebuggerDocumentWithExceptionInExample >> setUp [
	
	GtInspector openOnPlayBook: (GtDocument new text: '!An example with an exception
${example:GtDummyExamplesWithExceptions class>>#j}$
')
]
