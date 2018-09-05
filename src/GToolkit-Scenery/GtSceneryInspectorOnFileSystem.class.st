Class {
	#name : #GtSceneryInspectorOnFileSystem,
	#superclass : #GtScenery,
	#category : #'GToolkit-Scenery'
}

{ #category : #'world menu' }
GtSceneryInspectorOnFileSystem class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 50.0; 
		parent: #GToolkitScenery;
		label: 'Inspector: file system';
		action: [self new setUp]
]

{ #category : #initialization }
GtSceneryInspectorOnFileSystem >> setUp [
	(GtInspector openOn: '.' asFileReference) 
]
