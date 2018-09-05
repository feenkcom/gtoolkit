Class {
	#name : #GtSceneryInspectorOnGtInspector,
	#superclass : #GtScenery,
	#category : #'GToolkit-Scenery'
}

{ #category : #'world menu' }
GtSceneryInspectorOnGtInspector class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 100.0; 
		parent: #GToolkitScenery;
		label: 'Inspector: GtInspector';
		action: [self new setUp];
		withSeparatorAfter
]

{ #category : #initialization }
GtSceneryInspectorOnGtInspector >> setUp [
	| book |
	book := GtPlayBook new.
	book pages first snippets first sourceCode: 'GtInspector'.	
	GtInspector openOnPlayBook: book
]
