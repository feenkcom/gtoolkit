Extension { #name : #Collection }

{ #category : #'*GToolkit-Extensions' }
Collection >> gtLiveFor: aView [
	^ self gtTreeFor: aView
]

{ #category : #'*GToolkit-Extensions' }
Collection >> gtTreeFor: aView [

	^ aView forward
		  title: 'Tree';
		  priority: 51;
		  object: [ self ];
		  view: #gtTreeFor:context:
]

{ #category : #'*GToolkit-Extensions' }
Collection >> gtTreeFor: aView context: aContext [

	<gtView>
	| anIndexStyler aValueStyler |
	anIndexStyler := aContext 
		at: #gtTreeIndexStyler 
		ifAbsent: [ [ :anAssoc | 
			anAssoc key gtDisplayText 
				asRopedText foreground: Color gray ] ].
	aValueStyler := aContext
		at: #gtTreeValueStyler
		ifAbsent: [ [ :anAssoc | anAssoc value gtDisplayText ] ].

	^ aView columnedTree
		  title: 'Tree';
		  priority: 51;
		  items: [ 
			  self isDictionary
				  ifTrue: [ self associations ]
				  ifFalse: [ 
					  self asOrderedCollection withIndexCollect: [ :aValue :aKey | 
							  aKey -> aValue ] ] ];
		  children: [ :anAssoc | 
			  anAssoc value isDictionary
				  ifTrue: [ anAssoc value associations ]
				  ifFalse: [ 
					  (anAssoc value isCollection and: [ anAssoc value isString not ])
						  ifTrue: [ 
							  anAssoc value asOrderedCollection withIndexCollect: [ 
									  :aValue 
									  :aKey | aKey -> aValue ] ]
						  ifFalse: [ #(  ) ] ] ];
		  actionUpdateButtonTooltip: 'Update tree';
		  column: 'Index'
		  text: [ :anAssoc :anIndex | 
			  anIndexStyler cull: anAssoc cull: anIndex ];
		  column: 'Item'
		  text: [ :anAssoc :anIndex | 
			  aValueStyler cull: anAssoc cull: anIndex ]
		  weight: 3;
		  in: [ :theNewView |
		  	aContext 
				at: #gtTreeExpansionLevel
				ifPresent: [ :anObject | 
					anObject isNumber 
						ifTrue: [ theNewView expandUpTo: anObject ]
						ifFalse: [ anObject = true ifTrue: [
							theNewView expandAll ] ] ] 
				ifAbsent: [ [ :anAssoc | 
					anAssoc key gtDisplayText 
						asRopedText foreground: Color gray ] ] ];
		  send: [ :anAssoc | anAssoc value ]
]
