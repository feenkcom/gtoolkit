Class {
	#name : #GtSceneryDocumenterCompletion,
	#superclass : #GtScenery,
	#category : #'GToolkit-Scenery'
}

{ #category : #'world menu' }
GtSceneryDocumenterCompletion class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 255.0; 
		parent: #GToolkitScenery;
		label: 'Documenter: completion';
		action: [self new setUp];
		withSeparatorAfter
]

{ #category : #initialization }
GtSceneryDocumenterCompletion >> setUp [
	| documenter |
	documenter := GtDocumenter editorForText: '!Completion in Documenter

!!Completion for Pharo scripts in Documenter

Just start typing code in the snippet below.

[[[

]]]


'.
	GtInspector openOnPlayBook: documenter
]
