Extension { #name : #OSEnvironment }

{ #category : #'*GToolkit-Extensions' }
OSEnvironment >> gtEnvironmentFor: aView [
	<gtView>
	^ aView columnedList
		title: 'Environment';
		items: [ self gtItems ];
		column: 'Name' text: #key;
		column: 'Value' text: #value;
		actionUpdateButton;
		contextItemLabel: 'Remove'
			action: [ :anElement :anAssoc | 
				self removeKey: anAssoc key.
				anElement phlow fireUpdateWish ];
		send: #value
]

{ #category : #'*GToolkit-Extensions' }
OSEnvironment >> gtItems [
	| anArray |
	anArray := Array
			streamContents: [ :aStream | self keysAndValuesDo: [ :aKey :aValue | aStream nextPut: aKey -> aValue ] ].

	anArray sort: [ :a :b | a key asString < b key asString ].

	^ anArray
]
