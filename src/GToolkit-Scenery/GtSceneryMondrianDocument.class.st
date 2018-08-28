Class {
	#name : #GtSceneryMondrianDocument,
	#superclass : #GtScenery,
	#category : #'GToolkit-Scenery'
}

{ #category : #'world menu' }
GtSceneryMondrianDocument class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 200.0; 
		parent: #GToolkitScenery;
		label: 'Mondrian document';
		action: [self new setUp]
]

{ #category : #initialization }
GtSceneryMondrianDocument >> setUp [
	| book |
	book := GtPlayBook new.
	book pages first snippets first sourceCode: 'IceRepository repositoriesLocation / ''feenkcom''/ ''gtoolkit-visualizer'' / ''doc'' / ''mondrian'' / ''index.pillar'''.
	(GtInspector openOnPlayBook: book)
]
