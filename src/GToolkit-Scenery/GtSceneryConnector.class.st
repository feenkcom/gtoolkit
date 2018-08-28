Class {
	#name : #GtSceneryConnector,
	#superclass : #GtScenery,
	#category : #'GToolkit-Scenery'
}

{ #category : #'world menu' }
GtSceneryConnector class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 200.0; 
		parent: #GToolkitScenery;
		label: 'Connector';
		action: [self new setUp]
]

{ #category : #initialization }
GtSceneryConnector >> setUp [
	(GtInspector openOn: GtConnectorExamples new oneExampleMethod) 
]
