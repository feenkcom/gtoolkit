Class {
	#name : #GtSceneryDocumenterTutorialInClassComments,
	#superclass : #GtScenery,
	#category : #'GToolkit-Scenery'
}

{ #category : #'world menu' }
GtSceneryDocumenterTutorialInClassComments class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 230.0; 
		parent: #GToolkitScenery;
		label: 'Documenter: Bloc class comments';
		action: [self new setUp]
]

{ #category : #initialization }
GtSceneryDocumenterTutorialInClassComments >> setUp [
	| book |
	book := GtPlayBook new.
	book pages first snippets first sourceCode: 'BrToggleExamples'.
	(GtInspector openOnPlayBook: book)
]
