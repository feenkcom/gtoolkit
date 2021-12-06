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
	anIndexStyler := aContext at: #gtTreeIndexStyler ifAbsent: [ 
		                 [ :aNode | 
		                 aNode key gtDisplayText asRopedText foreground:
			                 Color gray ] ].
	aValueStyler := aContext
		                at: #gtTreeValueStyler
		                ifAbsent: [ [ :aNode | aNode value gtDisplayText ] ].

	^ aView columnedTree
		  title: 'Tree';
		  priority: 51;
		  items: [ GtTreeNode fromCollection: self ];
		  children: [ :aNode | 
			  (aNode value isCollection and: [ aNode value isString not ])
				  ifTrue: [ GtTreeNode fromNode: aNode ]
				  ifFalse: [ #(  ) ] ];
		  actionUpdateButtonTooltip: 'Update tree';
		  column: 'Index'
		  text: [ :aNode :anIndex | anIndexStyler cull: aNode cull: anIndex ];
		  column: 'Item'
		  text: [ :aNode :anIndex | aValueStyler cull: aNode cull: anIndex ]
		  weight: 3;
		  in: [ :theNewView | 
			  aContext
				  at: #gtTreeExpansionLevel
				  ifPresent: [ :anObject | 
					  anObject isNumber
						  ifTrue: [ theNewView expandUpTo: anObject ]
						  ifFalse: [ anObject = true ifTrue: [ theNewView expandAll ] ] ]
				  ifAbsent: [ "ignore" ] ];
		  send: [ :aNode | aNode value ]
]
