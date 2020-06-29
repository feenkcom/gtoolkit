Class {
	#name : #GtNewsItem,
	#superclass : #Object,
	#instVars : [
		'id',
		'status',
		'trigger',
		'cardStencil'
	],
	#category : #'GToolkit-World-News'
}

{ #category : #accessing }
GtNewsItem >> cardStencil [
	^ cardStencil
]

{ #category : #accessing }
GtNewsItem >> cardStencil: anObject [
	cardStencil := anObject
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
GtNewsItem >> status [
	^ status
]

{ #category : #accessing }
GtNewsItem >> status: anObject [
	status := anObject
]

{ #category : #accessing }
GtNewsItem >> trigger [
	^ trigger
]

{ #category : #accessing }
GtNewsItem >> trigger: anObject [
	trigger := anObject
]
