Class {
	#name : #GtSceneryReleaserForGT,
	#superclass : #GtScenery,
	#category : #'GToolkit-Scenery'
}

{ #category : #'world menu' }
GtSceneryReleaserForGT class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 950.0; 
		parent: #GToolkitScenery;
		label: 'Releaser: GT';
		action: [self new setUp]
]

{ #category : #initialization }
GtSceneryReleaserForGT >> setUp [
	| book |
	book := GtPlayBook newDefault.
	book pages first snippets first sourceCode: 'GtRlReleaserExportWorkflow buildGToolkitRelease'.
	GtInspector openOnPlayBook: book
]
