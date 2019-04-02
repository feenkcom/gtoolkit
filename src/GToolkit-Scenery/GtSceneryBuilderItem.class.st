Class {
	#name : #GtSceneryBuilderItem,
	#superclass : #Object,
	#instVars : [
		'order',
		'name',
		'action'
	],
	#category : #'GToolkit-Scenery'
}

{ #category : #accessing }
GtSceneryBuilderItem >> action [
	^ action
]

{ #category : #accessing }
GtSceneryBuilderItem >> action: anObject [
	action := anObject
]

{ #category : #accessing }
GtSceneryBuilderItem >> label: aString [
	self name: aString
]

{ #category : #accessing }
GtSceneryBuilderItem >> name [
	^ name
]

{ #category : #accessing }
GtSceneryBuilderItem >> name: anObject [
	name := anObject
]

{ #category : #accessing }
GtSceneryBuilderItem >> order [
	^ order
]

{ #category : #accessing }
GtSceneryBuilderItem >> order: anObject [
	order := anObject
]

{ #category : #accessing }
GtSceneryBuilderItem >> parent: anObject [
	"just compatilibity with the Pharo menu"
]

{ #category : #accessing }
GtSceneryBuilderItem >> withSeparatorAfter [
	"just compatilibity with the Pharo menu"
]

{ #category : #accessing }
GtSceneryBuilderItem >> withSeparatorBefore [
	"just compatilibity with the Pharo menu"
]
