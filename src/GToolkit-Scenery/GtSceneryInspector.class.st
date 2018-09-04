Class {
	#name : #GtSceneryInspector,
	#superclass : #GtScenery,
	#category : #'GToolkit-Scenery'
}

{ #category : #'world menu' }
GtSceneryInspector class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 400.0; 
		parent: #GToolkitScenery;
		label: 'Inspector';
		action: [self new setUp]
]

{ #category : #initialization }
GtSceneryInspector >> setUp [
	| book |
	book := GtPlayBook new.
	book pages first snippets first sourceCode: 'GtInspector'.	
	GtInspector openOnPlayBook: book
]
