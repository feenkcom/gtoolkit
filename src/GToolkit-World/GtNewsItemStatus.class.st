"
I model a status for a news on the home screen. My subclasses provide concrete statuses. Curently only the ""viewed"" status is supported.
"
Class {
	#name : #GtNewsItemStatus,
	#superclass : #Object,
	#category : #'GToolkit-World-News'
}

{ #category : #accessing }
GtNewsItemStatus class >> registryValue [
	self subclassResponsibility
]

{ #category : #testing }
GtNewsItemStatus >> isViewed [
	^ false
]

{ #category : #accessing }
GtNewsItemStatus >> registryValue [
	^ self class registryValue
]
