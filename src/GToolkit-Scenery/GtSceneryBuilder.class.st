Class {
	#name : #GtSceneryBuilder,
	#superclass : #Object,
	#instVars : [
		'items'
	],
	#category : #'GToolkit-Scenery'
}

{ #category : #building }
GtSceneryBuilder class >> build [	
	| builder |
	builder := self new.
	GtScenery allSubclassesDo: [ :c | 
		(Pragma allNamed: #worldMenu in: c class) do: [ :pragma |
			c perform: pragma methodSelector withArguments: { builder } ]
		 ].
	^ builder
]

{ #category : #initialize }
GtSceneryBuilder >> initialize [
	super initialize.
	items := OrderedCollection new
]

{ #category : #accessing }
GtSceneryBuilder >> item: aString [
	| item |
	item := GtSceneryBuilderItem new.
	items add: item.
	^ item
]

{ #category : #accessing }
GtSceneryBuilder >> items [
	^ items sorted: [ :a :b | a order < b order ]
]
