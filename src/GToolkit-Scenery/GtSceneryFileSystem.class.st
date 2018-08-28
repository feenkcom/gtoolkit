Class {
	#name : #GtSceneryFileSystem,
	#superclass : #GtScenery,
	#category : #'GToolkit-Scenery'
}

{ #category : #'world menu' }
GtSceneryFileSystem class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 200.0; 
		parent: #GToolkitScenery;
		label: 'Examples tutorial';
		action: [self new setUp]
]

{ #category : #initialization }
GtSceneryFileSystem >> setUp [
	(GtInspector openOn: '.' asFileReference) 
]
