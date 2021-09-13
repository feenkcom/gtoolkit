Extension { #name : 'Collection' }

{ #category : '*GToolkit-Extensions' }
Collection >> gtLiveFor: aView [
	^ self gtTreeFor: aView
]

{ #category : '*GToolkit-Extensions' }
Collection >> gtTreeFor: aView [

	<gtView>
	^ aView columnedTree
		  title: 'Tree';
		  priority: 51;
		  items: [ 
			  self isDictionary
				  ifTrue: [ self associations ]
				  ifFalse: [ self asOrderedCollection ] ];
		  children: [ :eachItem | 
			  eachItem isDictionary
				  ifTrue: [ eachItem associations ]
				  ifFalse: [ 
					  (eachItem isKindOf: Association)
						  ifTrue: [ 
							  eachItem value isDictionary
								  ifTrue: [ eachItem value associations ]
								  ifFalse: [ 
									  (eachItem value isCollection and: [ 
											   eachItem value isString not ])
										  ifTrue: [ eachItem value asOrderedCollection ]
										  ifFalse: [ #(  ) ] ] ]
						  ifFalse: [ #(  ) ] ] ];
		  actionUpdateButtonTooltip: 'Update tree';
		  column: 'Index' text: [ :eachItem :eachIndex | 
			  | aKey |
			  aKey := (eachItem isKindOf: Association)
				          ifTrue: [ eachItem key ]
				          ifFalse: [ eachIndex ].
			  aKey asRopedText foreground: Color gray ];
		  column: 'Item' text: [ :eachItem | 
			  | aKey |
			  aKey := (eachItem isKindOf: Association)
				          ifTrue: [ eachItem value gtDisplayText ]
				          ifFalse: [ eachItem gtDisplayText ] ]
		  weight: 3;
		  send: [ :anItem | 
			  (anItem isKindOf: Association)
				  ifTrue: [ anItem value ]
				  ifFalse: [ anItem ] ]
]
