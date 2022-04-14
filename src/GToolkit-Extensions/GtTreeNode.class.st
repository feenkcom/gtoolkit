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

	^ self
		  fromCollection: aCollection
		  parent: (self new value: aCollection)
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

	^ self
		  fromDictionary: aDictionary
		  parent: (self new value: aDictionary)
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

{ #category : #'gt - extensions' }
GtTreeNode >> gtHierarchyFor: aView [

	<gtView>
	^ aView columnedList
		  title: 'Hierarchy';
		  priority: 1;
		  items: [ self withParents ];
		  column: 'Depth' text: [ :aNode :anIndex | anIndex ] width: 50;
		  column: 'Key' text: #gtKeyText;
		  column: 'Value' text: #value weight: 3
]

{ #category : #'gt - extensions' }
GtTreeNode >> gtKeyText [

	^ self isRoot
		  ifTrue: [ 
			  'root' asRopedText foreground:
				  BrGlamorousColors disabledButtonTextColor ]
		  ifFalse: [ self key ]
]

{ #category : #testing }
GtTreeNode >> hasParent [
	^ self parent isNotNil
]

{ #category : #testing }
GtTreeNode >> isRoot [

	^ self parent isNil and: [ self key isNil ]
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

{ #category : #enumerating }
GtTreeNode >> withParents [

	^ Array streamContents: [ :aStream | 
		  self withParentsDo: [ :eachNode | aStream nextPut: eachNode ] ]
]

{ #category : #enumerating }
GtTreeNode >> withParentsDo: aBlock [

	self parent ifNotNil: [ :aParent | aParent withParentsDo: aBlock ].

	aBlock cull: self
]
