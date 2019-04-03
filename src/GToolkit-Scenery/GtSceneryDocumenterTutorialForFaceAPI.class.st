Class {
	#name : #GtSceneryDocumenterTutorialForFaceAPI,
	#superclass : #GtScenery,
	#category : #'GToolkit-Scenery'
}

{ #category : #'world menu' }
GtSceneryDocumenterTutorialForFaceAPI class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 221.0; 
		parent: #GToolkitScenery;
		label: 'Documenter: Face API';
		action: [self new setUp]
]

{ #category : #initialization }
GtSceneryDocumenterTutorialForFaceAPI >> setUp [
	GtInspector openOnPlayBook: (GtDocument forFile: (GtIcebergUtility documentAtPath: (Path *
		'feenkcom'/ 'gtoolkit-demos' / 'doc' / 'tutorial' / 'esug-2018' /
		'esug-2018-exemplifying-software.pillar')))
]
