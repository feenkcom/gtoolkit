Class {
	#name : #GtSceneryConnectorForHospitalityExample,
	#superclass : #GtScenery,
	#category : #'GToolkit-Scenery'
}

{ #category : #'world menu' }
GtSceneryConnectorForHospitalityExample class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: self name)
		order: 510.0; 
		parent: #GToolkitScenery;
		label: 'Connector: for hospitality example';
		action: [self new setUp];
		withSeparatorAfter
]

{ #category : #initialization }
GtSceneryConnectorForHospitalityExample >> setUp [
	GtInspector openOn: (OFPizzaExamples>>#pizzaMargheritaWithDiscountedPrice) gtExample
]
