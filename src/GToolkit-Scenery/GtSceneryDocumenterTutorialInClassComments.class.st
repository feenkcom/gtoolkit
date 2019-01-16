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
	GtInspector openOnPlayBook: (Gt2Document forClass: BrToggleExamples)
]
