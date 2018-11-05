Class {
	#name : #GtSceneryDocumenterTalk,
	#superclass : #GtScenery,
	#category : #'GToolkit-Scenery'
}

{ #category : #'world menu' }
GtSceneryDocumenterTalk class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 222.0; 
		parent: #GToolkitScenery;
		label: 'Documenter: Three Use Case Scenarios Talk';
		action: [self new setUp]
]

{ #category : #initialization }
GtSceneryDocumenterTalk >> setUp [
	| aRegistry aFileReference | 
	aRegistry := IceRepository registry detect: [ :each | each name = 'gtoolkit-demos' ].
	aFileReference := aRegistry location / 'doc' / 'tutorial' / 'esug-2018-documenter' / 'documenter.pillar'.
	GtInspector openOn: aFileReference
]
