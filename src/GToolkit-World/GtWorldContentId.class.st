Class {
	#name : #GtWorldContentId,
	#superclass : #BlElementUniqueId,
	#category : #'GToolkit-World-UI - ID'
}

{ #category : #testing }
GtWorldContentId class >> isAbstract [
	^ self name = #GtWorldContentId 
]
