Class {
	#name : #GtSceneryDebuggerDocumentWithExceptionInExample,
	#superclass : #GtScenery,
	#category : #'GToolkit-Scenery'
}

{ #category : #'world menu' }
GtSceneryDebuggerDocumentWithExceptionInExample class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 501.0; 
		parent: #GToolkitScenery;
		label: 'Debugger: on documenter with exception in example';
		action: [self new setUp]
]

{ #category : #initialization }
GtSceneryDebuggerDocumentWithExceptionInExample >> setUp [
	
	GtInspector openOnPlayBook: (GtDocumenter editorForText: '!An example with an exception
${example:GtDummyExamplesWithExceptions class>>#j}$
')
]
