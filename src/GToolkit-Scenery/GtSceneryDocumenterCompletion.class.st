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
	(GtInspector openOn: ('./feenk' asFileReference / 'esug2018'))
]
