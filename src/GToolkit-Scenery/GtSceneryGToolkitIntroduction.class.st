Class {
	#name : #GtSceneryGToolkitIntroduction,
	#superclass : #GtScenery,
	#category : #'GToolkit-Scenery'
}

{ #category : #'world menu' }
GtSceneryGToolkitIntroduction class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 200.0; 
		parent: #GToolkitScenery;
		label: 'Introduction to GToolkit';
		action: [self new setUp]
]

{ #category : #initialization }
GtSceneryGToolkitIntroduction >> setUp [
	(GtInspector openOn: (IceRepository repositoriesLocation / 'feenkcom'/ 'gtoolkit' / 'doc' / 'gtoolkit' / 'gtoolkit.pillar')) 
]
