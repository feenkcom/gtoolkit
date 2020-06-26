"
I am status indicating that a card has been viewed by the user.
"
Class {
	#name : #GtNewsItemViewedStatus,
	#superclass : #GtNewsItemStatus,
	#category : #'GToolkit-World-News'
}

{ #category : #testing }
GtNewsItemViewedStatus >> isViewed [
	^ true
]

{ #category : #accessing }
GtNewsItemViewedStatus >> registryValue [
	^ 'viewed'
]
