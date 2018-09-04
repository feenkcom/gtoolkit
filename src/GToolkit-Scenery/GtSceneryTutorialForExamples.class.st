Class {
	#name : #GtSceneryTutorialForExamples,
	#superclass : #GtScenery,
	#category : #'GToolkit-Scenery'
}

{ #category : #'world menu' }
GtSceneryTutorialForExamples class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 220.0; 
		parent: #GToolkitScenery;
		label: 'Examples tutorial';
		action: [self new setUp]
]

{ #category : #initialization }
GtSceneryTutorialForExamples >> setUp [
	(GtInspector openOn: (IceRepository repositoriesLocation / 'feenkcom'/ 'gtoolkit-examples' / 'doc' / 'tutorial' / 'examples-tutorial.pillar'))
]
