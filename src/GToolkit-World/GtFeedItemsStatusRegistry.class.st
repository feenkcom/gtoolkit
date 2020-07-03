Class {
	#name : #GtFeedItemsStatusRegistry,
	#superclass : #GtInteractiveStatusRegistry,
	#category : #'GToolkit-World-Notifications'
}

{ #category : #accessing }
GtFeedItemsStatusRegistry class >> currentSchemaVersion [
	^ 'v1'
]

{ #category : #accessing }
GtFeedItemsStatusRegistry class >> registryFileName [
	^ 'com.glamoroustoolkit.feed-item-statuses'
]
