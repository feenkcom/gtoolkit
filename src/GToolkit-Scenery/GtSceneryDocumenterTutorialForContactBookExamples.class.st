Class {
	#name : #GtSceneryDocumenterTutorialForContactBookExamples,
	#superclass : #GtScenery,
	#category : #'GToolkit-Scenery'
}

{ #category : #'world menu' }
GtSceneryDocumenterTutorialForContactBookExamples class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 221.0; 
		parent: #GToolkitScenery;
		label: 'Documenter: Examples tutorial - Address Book';
		action: [self new setUp]
]

{ #category : #initialization }
GtSceneryDocumenterTutorialForContactBookExamples >> setUp [
	GtInspector openOnPlayBook: (GtDocument forFile: (
		GtIcebergUtility documentAtPath: (Path * 
			'feenkcom'/ 'gtoolkit-demos' 
			/ 'doc' / 'tutorial' 
			/ 'smalltalks-2018-addressbook' / 'example-driven-development.pillar' )))
]
