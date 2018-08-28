Class {
	#name : #GtScenery,
	#superclass : #Object,
	#category : #'GToolkit-Scenery'
}

{ #category : #'world menu' }
GtScenery class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: #GToolkitScenery)
		order: 1; 
		label: 'GToolkit Scenery';
		withSeparatorAfter
]

{ #category : #utilities }
GtScenery >> cleanWindows [
	(World submorphs 
		select: [ :each | each isKindOf: SystemWindow ])
		do: #delete
]

{ #category : #setUp }
GtScenery >> setUp [
	
]
