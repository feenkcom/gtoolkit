Class {
	#name : #GtSceneryConnectorForExample,
	#superclass : #GtScenery,
	#category : #'GToolkit-Scenery'
}

{ #category : #'world menu' }
GtSceneryConnectorForExample class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 500.0; 
		parent: #GToolkitScenery;
		label: 'Connector: for examples';
		action: [self new setUp]
]
