Class {
	#name : #GtSceneryTutorialForMondrian,
	#superclass : #GtScenery,
	#category : #'GToolkit-Scenery'
}

{ #category : #'world menu' }
GtSceneryTutorialForMondrian class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 210.0; 
		parent: #GToolkitScenery;
		label: 'Mondrian tutorial';
		action: [self new setUp]
]

{ #category : #initialization }
GtSceneryTutorialForMondrian >> setUp [
	| book |
	book := GtPlayBook new.
	book pages first snippets first sourceCode: 'IceRepository repositoriesLocation / ''feenkcom''/ ''gtoolkit-visualizer'' / ''doc'' / ''mondrian'' / ''index.pillar'''.
	(GtInspector openOnPlayBook: book)
]
