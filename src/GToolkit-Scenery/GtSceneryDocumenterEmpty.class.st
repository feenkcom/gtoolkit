Class {
	#name : #GtSceneryDocumenterEmpty,
	#superclass : #GtScenery,
	#category : #'GToolkit-Scenery'
}

{ #category : #'world menu' }
GtSceneryDocumenterEmpty class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 235.0; 
		parent: #GToolkitScenery;
		label: 'Documenter: Empty';
		action: [self new setUp];
		withSeparatorAfter
]

{ #category : #initialization }
GtSceneryDocumenterEmpty >> setUp [
	GtInspector openOnPlayBook: (GtDocument new)
]
