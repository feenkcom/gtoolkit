"
I am a null status, indicating that a news does not have a status. I am the default status of a news. 
"
Class {
	#name : #GtNewsItemNullStatus,
	#superclass : #GtNewsItemStatus,
	#category : #'GToolkit-World-News'
}

{ #category : #accessing }
GtNewsItemNullStatus class >> registryValue [
	^ 'null'
]
