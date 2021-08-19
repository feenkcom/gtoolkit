Extension { #name : 'TGtOptions' }

{ #category : '*GToolkit-Extensions' }
TGtOptions >> gtOptionsFor: aView [

	<gtView>
	self hasOptions ifFalse: [ ^ aView empty ].
	^ aView columnedTree
		  title: 'Options';
		  items: [ options ifNotNil: #associations ifNil: [ #(  ) ] ];
		  children: [ :each | 
			  each value isDictionary
				  ifTrue: [ each value associations ]
				  ifFalse: [ 
					  (each value isArray and: [ 
							   each value allSatisfy: #isDictionary ])
						  ifTrue: [ each value collectWithIndex: [ :x :i | i -> x ] ]
						  ifFalse: [ #(  ) ] ] ];
		  column: 'Key' stencil: [ :assoc | 
			  BrHorizontalPane new
				  hMatchParent;
				  vFitContent;
				  addChild: (BrLabel new
						   aptitude: BrGlamorousLabelAptitude;
						   hFitContentLimited;
						   text: assoc key asRopedText);
				  addChild: (BrButton new
						   beMiniSize;
						   aptitude: BrGlamorousButtonWithIconAptitude;
						   visibility: BlVisibility hidden;
						   margin: (BlInsets left: 5);
						   icon: BrGlamorousVectorIcons remove;
						   label: 'Remove ' , assoc key asString;
						   action: [ :aButton | 
							   self clearOption: assoc key ifAbsent: [ "ignore" ].
							   aButton phlow firstParentWithView
								   ifNotNil: [ :anElement | anElement phlow update ]
								   ifNil: [ aButton phlow fireUpdateWish ] ];
						   constraintsDo: [ :c | c linear vertical alignCenter ]);
				  when: BlMouseEnterEvent do: [ :anEvent | 
				  (anEvent currentTarget childAt: 2) visibility:
					  BlVisibility visible ];
				  when: BlMouseLeaveEvent do: [ :anEvent | 
				  (anEvent currentTarget childAt: 2) visibility:
					  BlVisibility hidden ] ]
		  weight: 0.5;
		  column: 'Value' text: [ :assoc | assoc value ];
		  send: [ :assoc | assoc value ]
]
