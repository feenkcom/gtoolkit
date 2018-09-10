Class {
	#name : #GtSceneryPlaygroundOnePharoSnippetWithFolder,
	#superclass : #GtScenery,
	#category : #'GToolkit-Scenery'
}

{ #category : #'world menu' }
GtSceneryPlaygroundOnePharoSnippetWithFolder class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 410.0; 
		parent: #GToolkitScenery;
		label: 'Playground: File system';
		action: [self new setUp]
]

{ #category : #initialization }
GtSceneryPlaygroundOnePharoSnippetWithFolder >> setUp [
	| book |
	book := GtPlayBook newDefault.
	book pages first snippets first sourceCode: 'directories := ''feenk'' asFileReference allDirectories.'.
	
	GtInspector openOnPlayBook: book
]
