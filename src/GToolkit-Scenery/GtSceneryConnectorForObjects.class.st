Class {
	#name : #GtSceneryConnectorForObjects,
	#superclass : #GtScenery,
	#category : #'GToolkit-Scenery'
}

{ #category : #'world menu' }
GtSceneryConnectorForObjects class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 501.0; 
		parent: #GToolkitScenery;
		label: 'Connector: for objects';
		action: [self new setUp]
]

{ #category : #initialization }
GtSceneryConnectorForObjects >> setUp [
	GtInspector openOn: BrToggleExamples new toggleWithMaterialChangingIcon
]
