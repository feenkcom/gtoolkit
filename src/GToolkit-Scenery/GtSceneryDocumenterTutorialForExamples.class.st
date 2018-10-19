Class {
	#name : #GtSceneryDocumenterTutorialForExamples,
	#superclass : #GtScenery,
	#category : #'GToolkit-Scenery'
}

{ #category : #'world menu' }
GtSceneryDocumenterTutorialForExamples class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 220.0; 
		parent: #GToolkitScenery;
		label: 'Documenter: Examples tutorial';
		action: [self new setUp]
]

{ #category : #initialization }
GtSceneryDocumenterTutorialForExamples >> setUp [
	GtInspector openOnPlayBook: (GtDocumenter editorForPillar: (GtIcebergUtility repositoriesLocation / 'feenkcom'/ 'gtoolkit-examples' / 'doc' / 'tutorial' / 'examples-tutorial.pillar'))
]
