Class {
	#name : #GtWorldSpaceTabId,
	#superclass : #BlElementId,
	#instVars : [
		'spaceId'
	],
	#category : #'GToolkit-World-UI - ID'
}

{ #category : #'api - instance creation' }
GtWorldSpaceTabId class >> spaceId: anInteger [
	^ self new spaceId: anInteger
]

{ #category : #comparing }
GtWorldSpaceTabId >> = anObject [
	^ self class = anObject class and: [ 
		self spaceId = anObject spaceId ]
]

{ #category : #converting }
GtWorldSpaceTabId >> asSymbol [
	^ Symbol streamContents: [ :aStream |
		aStream 
			nextPutAll: 'gt-world--space-tab-'; 
			print: self spaceId ]
]

{ #category : #comparing }
GtWorldSpaceTabId >> hash [
	^ self class hash bitXor: [ 
		self spaceId hash ]
]

{ #category : #accessing }
GtWorldSpaceTabId >> spaceId [
	^ spaceId
]

{ #category : #accessing }
GtWorldSpaceTabId >> spaceId: anInteger [
	spaceId := anInteger
]
