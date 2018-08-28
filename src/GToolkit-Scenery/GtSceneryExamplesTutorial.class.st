Class {
	#name : #GtSceneryExamplesTutorial,
	#superclass : #GtScenery,
	#category : #'GToolkit-Scenery'
}

{ #category : #'world menu' }
GtSceneryExamplesTutorial class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 200.0; 
		parent: #GToolkitScenery;
		label: 'Examples tutorial';
		action: [self new setUp]
]

{ #category : #initialization }
GtSceneryExamplesTutorial >> setUp [
	(GtInspector openOn: (IceRepository repositoriesLocation / 'feenkcom'/ 'gtoolkit-examples' / 'doc' / 'tutorial' / 'examples-tutorial.pillar'))
]
