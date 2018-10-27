Class {
	#name : #GtSceneryCoderOnQuery,
	#superclass : #GtScenery,
	#category : #'GToolkit-Scenery'
}

{ #category : #'world menu' }
GtSceneryCoderOnQuery class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 450.0; 
		parent: #GToolkitScenery;
		label: 'Coder: Query';
		action: [self new setUp];
		withSeparatorAfter
]

{ #category : #initialization }
GtSceneryCoderOnQuery >> setUp [
		| book |
	book := GtPlayBook newDefault.
	book pages first snippets first sourceCode: '#gtView gtPragmas & #list gtReferences'.	
	GtInspector openOnPlayBook: book
]
