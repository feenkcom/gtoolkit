Class {
	#name : #GtSceneryDocumenterTutorialForMondrian,
	#superclass : #GtScenery,
	#category : #'GToolkit-Scenery'
}

{ #category : #'world menu' }
GtSceneryDocumenterTutorialForMondrian class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 210.0; 
		parent: #GToolkitScenery;
		label: 'Documenter: Mondrian tutorial';
		action: [self new setUp]
]

{ #category : #initialization }
GtSceneryDocumenterTutorialForMondrian >> setUp [
	GtInspector openOnPlayBook: (GtDocument forClass: GtMondrianBasicExamples)
]
