Class {
	#name : #GtSceneryPlaygroundOnGtInspector,
	#superclass : #GtScenery,
	#category : #'GToolkit-Scenery'
}

{ #category : #'world menu' }
GtSceneryPlaygroundOnGtInspector class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 410.0; 
		parent: #GToolkitScenery;
		label: 'Playground: GtInspector';
		action: [self new setUp]
]

{ #category : #initialization }
GtSceneryPlaygroundOnGtInspector >> setUp [
	| book |
	book := GtPlayBook newDefault.
	book pages first snippets first sourceCode: 'GtInspector'.	
	GtInspector openOnPlayBook: book
]
