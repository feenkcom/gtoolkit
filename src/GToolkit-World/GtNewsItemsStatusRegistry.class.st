"
I provide support for marking news in the home screen as viewed.

I hold a list of status objects for neews and know how to persists it and read it from a STON preference file. For news that are viewed I return a ${class:GtNewsItemViewedStatus}$. Otherwise if no status was saved for a news I return a status of type ${class:GtNewsItemNullStatus}$.
"
Class {
	#name : #GtNewsItemsStatusRegistry,
	#superclass : #GtInteractiveNotificationStatusRegistry,
	#category : #'GToolkit-World-News'
}

{ #category : #accessing }
GtNewsItemsStatusRegistry class >> currentSchemaVersion [
	^ 'v1'
]

{ #category : #accessing }
GtNewsItemsStatusRegistry class >> registryFileName [
	^ 'com.glamoroustoolkit.news-items-statuses'
]

{ #category : #accessing }
GtNewsItemsStatusRegistry >> currentSchemaVersion [
	^ 'v1'
]
