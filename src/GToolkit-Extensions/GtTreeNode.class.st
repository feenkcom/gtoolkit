Class {
	#name : #GtTreeNode,
	#superclass : #Object,
	#instVars : [
		'key',
		'value',
		'parent'
	],
	#category : #'GToolkit-Extensions'
}

{ #category : #'instance creation' }
GtTreeNode class >> fromCollection: aCollection [

	^ self fromCollection: aCollection parent: nil
]

{ #category : #'instance creation' }
GtTreeNode class >> fromCollection: aCollection parent: aNodeOrNil [

	aCollection isDictionary ifTrue: [ 
		^ self fromDictionary: aCollection parent: aNodeOrNil ].

	^ aCollection asOrderedCollection withIndexCollect: [ :aValue :aKey | 
		  self new
			  key: aKey;
			  value: aValue;
			  parent: aNodeOrNil ]
]

{ #category : #'instance creation' }
GtTreeNode class >> fromDictionary: aDictionary [

	^ self fromDictionary: aDictionary parent: nil
]

{ #category : #'instance creation' }
GtTreeNode class >> fromDictionary: aDictionary parent: aNodeOrNil [

	^ aDictionary associations collect: [ :anAssoc | 
		  self new
			  key: anAssoc key;
			  value: anAssoc value;
			  parent: aNodeOrNil ]
]

{ #category : #'instance creation' }
GtTreeNode class >> fromNode: aNode [

	^ self fromCollection: aNode value parent: aNode
]

{ #category : #testing }
GtTreeNode >> hasParent [
	^ self parent isNotNil
]

{ #category : #accessing }
GtTreeNode >> key [

	^ key
]

{ #category : #accessing }
GtTreeNode >> key: anObject [

	key := anObject
]

{ #category : #accessing }
GtTreeNode >> parent [

	^ parent
]

{ #category : #accessing }
GtTreeNode >> parent: anObject [

	parent := anObject
]

{ #category : #printing }
GtTreeNode >> printOn: aStream [

	super printOn: aStream.

	self key ifNil: [ ^ self ].

	aStream nextPut: $(.
	aStream nextPutAll: self key asString.
	aStream nextPutAll: '->'.
	aStream nextPutAll: self value asString.
	aStream nextPut: $)
]

{ #category : #accessing }
GtTreeNode >> value [

	^ value
]

{ #category : #accessing }
GtTreeNode >> value: anObject [

	value := anObject
]
