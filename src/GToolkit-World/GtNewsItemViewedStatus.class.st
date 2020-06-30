"
I am status indicating that a news has been viewed by the user.
"
Class {
	#name : #GtNewsItemViewedStatus,
	#superclass : #GtNewsItemStatus,
	#category : #'GToolkit-World-News'
}

{ #category : #accessing }
GtNewsItemViewedStatus class >> registryValue [
	^ 'viewed'
]

{ #category : #testing }
GtNewsItemViewedStatus >> isViewed [
	^ true
]
