"
I am a null status, indicating that a card does not have a status. I am the default status of a card. 
"
Class {
	#name : #GtNewsItemNullStatus,
	#superclass : #GtNewsItemStatus,
	#category : #'GToolkit-World-News'
}

{ #category : #accessing }
GtNewsItemNullStatus >> registryValue [
	^ 'null'
]
