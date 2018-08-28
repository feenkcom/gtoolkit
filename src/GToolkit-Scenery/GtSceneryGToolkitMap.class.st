Class {
	#name : #GtSceneryGToolkitMap,
	#superclass : #GtScenery,
	#category : #'GToolkit-Scenery'
}

{ #category : #'world menu' }
GtSceneryGToolkitMap class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 200.0; 
		parent: #GToolkitScenery;
		label: 'GToolkit map';
		action: [self new setUp]
]

{ #category : #initialization }
GtSceneryGToolkitMap >> setUp [
	(GtInspector openOn: (IceRepository repositoriesLocation / 'feenkcom'/ 'gtoolkit' / 'doc' / 'gtoolkit' / 'gtoolkit.pillar')) 
]
