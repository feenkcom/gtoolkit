Class {
	#name : #GtSceneryDocumenterGToolkitIntroduction,
	#superclass : #GtScenery,
	#category : #'GToolkit-Scenery'
}

{ #category : #'world menu' }
GtSceneryDocumenterGToolkitIntroduction class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 200.0; 
		parent: #GToolkitScenery;
		label: 'Documenter: Introduction to GToolkit';
		action: [self new setUp]
]

{ #category : #initialization }
GtSceneryDocumenterGToolkitIntroduction >> setUp [
	(GtInspector openOn: (IceLibgitRepository repositoriesLocation / 'feenkcom'/ 'gtoolkit' / 'doc' / 'gtoolkit' / 'gtoolkit.pillar')) 
]
