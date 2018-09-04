Class {
	#name : #GtSceneryTutorialInClassComments,
	#superclass : #GtScenery,
	#category : #'GToolkit-Scenery'
}

{ #category : #'world menu' }
GtSceneryTutorialInClassComments class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 230.0; 
		parent: #GToolkitScenery;
		label: 'Bloc class comments';
		action: [self new setUp]
]

{ #category : #initialization }
GtSceneryTutorialInClassComments >> setUp [
	| book |
	book := GtPlayBook new.
	book pages first snippets first sourceCode: 'BrToggleExamples'.
	(GtInspector openOnPlayBook: book)
]
