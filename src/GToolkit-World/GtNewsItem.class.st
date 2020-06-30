"
I model a news item
"
Class {
	#name : #GtNewsItem,
	#superclass : #Object,
	#instVars : [
		'id',
		'status',
		'cardStencil',
		'openAction'
	],
	#category : #'GToolkit-World-News'
}

{ #category : #accessing }
GtNewsItem >> cardStencil [
	^ cardStencil
]

{ #category : #accessing }
GtNewsItem >> cardStencil: aCardStencil [
	cardStencil := aCardStencil.
	cardStencil action: [ :newsElement|
		self executeOpenFor: newsElement ]
]

{ #category : #actions }
GtNewsItem >> executeOpenFor: anElement [
	openAction cull: anElement.
	self status: GtNewsItemViewedStatus new.
	self statusRegistry markNewsViewedForId: self id
]

{ #category : #accessing }
GtNewsItem >> id [
	^ id
]

{ #category : #accessing }
GtNewsItem >> id: anId [
	id := anId
]

{ #category : #accessing }
GtNewsItem >> openAction: aBlock [
	openAction := aBlock
]

{ #category : #accessing }
GtNewsItem >> status [
	^ status
]

{ #category : #accessing }
GtNewsItem >> status: aStatus [
	status := aStatus
]

{ #category : #accessing }
GtNewsItem >> statusRegistry [
	^ GtNewsItemsStatusRegistry defaultInstance
]
