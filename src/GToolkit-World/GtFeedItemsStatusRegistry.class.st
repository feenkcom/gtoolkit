Class {
	#name : #GtFeedItemsStatusRegistry,
	#superclass : #GtInteractiveStatusRegistry,
	#category : #'GToolkit-World-Feed'
}

{ #category : #accessing }
GtFeedItemsStatusRegistry class >> currentSchemaVersion [
	^ 'v1'
]

{ #category : #accessing }
GtFeedItemsStatusRegistry class >> registryFileName [
	^ 'com.glamoroustoolkit.feed-item-statuses'
]
