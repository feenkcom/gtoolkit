Class {
	#name : #GtNewsItem,
	#superclass : #Object,
	#instVars : [
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
	^ self cardStencil id
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
