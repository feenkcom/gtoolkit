Class {
	#name : #GtSceneryBlocClassComments,
	#superclass : #GtScenery,
	#category : #'GToolkit-Scenery'
}

{ #category : #'world menu' }
GtSceneryBlocClassComments class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 200.0; 
		parent: #GToolkitScenery;
		label: 'Bloc class comments';
		action: [self new setUp]
]

{ #category : #initialization }
GtSceneryBlocClassComments >> setUp [
	| book |
	book := GtPlayBook new.
	book pages first snippets first sourceCode: 'BrToggleExamples'.
	(GtInspector openOnPlayBook: book)
]
