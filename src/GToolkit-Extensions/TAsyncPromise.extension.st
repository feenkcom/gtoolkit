Extension { #name : #TAsyncPromise }

{ #category : #'*GToolkit-Extensions' }
TAsyncPromise >> gtChainedPromises [
	"Return a collection of promises that are next in the chain after this one"
	<return: #Collection of: #TAsyncPromise>

	^ #()
]

{ #category : #'*GToolkit-Extensions' }
TAsyncPromise >> gtFullPromiseTreeFor: aView [
	<gtView>
	
	^ aView mondrian
		title: 'Full Tree';
		priority: 3;
		painting: [ :aMondrian | self gtPaintFullTreeOn: aMondrian ]
]

{ #category : #'*GToolkit-Extensions' }
TAsyncPromise >> gtHandlesErrors [
	"Return true if the promise is able to handle errors"

	^ false
]

{ #category : #'*GToolkit-Extensions' }
TAsyncPromise >> gtPaintFullTreeOn: aMondrian [
	| relations theChainedPromises thePrecedingPromises allPromises allFutures |
	
	relations := OrderedCollection new.
	thePrecedingPromises := OrderedCollection new.
	self 
		withDeep: #gtPrecedingPromises 
		do: [ :aPromise | thePrecedingPromises add: aPromise ] 
		relationDo: [ :from :to | relations add: from->to ].
	
	theChainedPromises := OrderedCollection new.
	self 
		withDeep: #gtChainedPromises 
		do: [ :aPromise | theChainedPromises add: aPromise ] 
		relationDo: [ :from :to | relations add: from->to ].

	allPromises := ({ self } asSet, theChainedPromises, thePrecedingPromises) asArray.

	allFutures := OrderedCollection new.
	allPromises do: [ :aPromise |
		aPromise relatedFutures do: [ :aFuture | 
			allFutures add: aFuture.
			relations add: aPromise -> aFuture ] ].	
	allFutures copy 
		withDeep: #gtCompositionChildren 
		do: [ :aFuture | allFutures add: aFuture ] 
		relationDo: [ :from :to | relations add: from->to ].
	allFutures := allFutures removeDuplicates.
	
	aMondrian nodes
		stencil: [ :eachPromise |
			BlElement new
				geometry: BlEllipseGeometry new;
				layout: BlFrameLayout new;
				size: 40@40;
				border: (BlBorder paint: Color black width: 2);
				background: (eachPromise == self
					ifTrue: [ BrGlamorousColors textHighlightColor ]
					ifFalse: [ Color white ]);
				in: [ :anElement |
					eachPromise gtHandlesErrors
						ifTrue: [ anElement addChild: (BrLabel new
							constraintsDo: [ :c |
								c frame horizontal alignCenter.
								c frame vertical alignCenter ];
							aptitude: (BrGlamorousLabelAptitude new fontSize: 5);
							text: 'Handles errors') ] ];
				yourself ];
		with: allPromises.
	aMondrian nodes
		stencil: [ :eachPromise |
			BlElement new
				geometry: BlRectangleGeometry new;
				layout: BlFrameLayout new;
				size: 40@40;
				border: (BlBorder paint: Color black width: 2);
				background: (eachPromise == self
					ifTrue: [ BrGlamorousColors textHighlightColor ]
					ifFalse: [ Color white ]);
				yourself ];
		with: allFutures.
		
	aMondrian edges 
		stencil: [
			BlSigmoidElement new
				beHorizontal;
				sharpness: 0.1;
				border: (BlBorder paint: (BrGlamorousColors defaultHeaderBackgroundColor alpha: 0.5) width: 2) ];
		fromRightCenter;
		toLeftCenter;
		connect: relations from: #key to: #value.

	aMondrian layout horizontalTree levelDistance: 30; nodeDistance: 10.
	
	^ aMondrian
]

{ #category : #'*GToolkit-Extensions' }
TAsyncPromise >> gtPaintTreeWith: aMondrian [
	| theChainedPromises thePrecedingPromises allPromises |
	
	thePrecedingPromises := self withDeepCollect: #gtPrecedingPromises.
	theChainedPromises := thePrecedingPromises withDeepCollect: #gtChainedPromises.
	allPromises := ({ self } asSet, theChainedPromises, thePrecedingPromises) asArray.

	aMondrian nodes
		stencil: [ :eachPromise |
			BlElement new
				geometry: BlEllipseGeometry new;
				layout: BlFrameLayout new;
				size: 40@40;
				border: (BlBorder paint: Color black width: 2);
				background: (eachPromise == self
					ifTrue: [ BrGlamorousColors textHighlightColor ]
					ifFalse: [ Color white ]);
				in: [ :anElement |
					eachPromise gtHandlesErrors
						ifTrue: [ anElement addChild: (BrLabel new
							constraintsDo: [ :c |
								c frame horizontal alignCenter.
								c frame vertical alignCenter ];
							aptitude: (BrGlamorousLabelAptitude new fontSize: 5);
							text: 'Handles errors') ] ];
				yourself ];
		with: allPromises.
		
	aMondrian edges 
		stencil: [
			BlSigmoidElement new
				beHorizontal;
				sharpness: 0.1;
				border: (BlBorder paint: (BrGlamorousColors defaultHeaderBackgroundColor alpha: 0.5) width: 2) ];
		fromRightCenter;
		toLeftCenter;
		connectToAll: #gtChainedPromises.

	aMondrian layout horizontalTree levelDistance: 30; nodeDistance: 10.
	
	^ aMondrian
]

{ #category : #'*GToolkit-Extensions' }
TAsyncPromise >> gtPrecedingPromises [
	"Return a collection promises on which this promise depends"
	<return: #Collection of: #TAsyncPromise>

	^ #()
]

{ #category : #'*GToolkit-Extensions' }
TAsyncPromise >> gtPromiseFor: aView [
	<gtView>
	
	^ aView explicit
		title: 'Promise';
		priority: 1;
		stencil: [
			BrFromPromise new
				matchParent;
				stencil: [
					BrHorizontalPane new
						matchParent;
						addAptitude: BrShadowAptitude new beLarge;
						geometry: (BlRoundedRectangleGeometry cornerRadius: 4);
						background: Color white;
						constraintsDo: [ :c |
							c frame horizontal alignCenter weight: 0.75.
							c frame vertical alignCenter weight: 0.75 ];
						addChild: (BrVerticalPane new
							hExact: 50;
							vMatchParent) as: #status;
						addChild: (BrVerticalPane new
							alignCenter;
							matchParent) as: #result ];
				dataBinder: [ :anElement :aData |
					| aResultElement aStatusElement |

					aStatusElement := anElement childWithId: #status.
					aResultElement := anElement childWithId: #result.
			
					aResultElement removeChildren.
					aData
						ifSuccess: [ :aValue |
							aStatusElement
								background: anElement theme status successBackgroundColor.
							aResultElement addChild: (GtInspector forObject: aValue) ]
						ifError: [ :anError |
							aStatusElement
								background: anElement theme status errorBackgroundColor.
							aResultElement
								addChild: anError asDebuggableElement ]
						ifPending: [
							aStatusElement
								background: anElement theme status neutralBackgroundColor.
							
							aResultElement
								addChild: (BrLabel new
									aptitude: (BrGlamorousLabelAptitude new foreground: Color lightGray);
									text: 'Awaiting a promised value...') ] ];
				promise: self ]
]

{ #category : #'*GToolkit-Extensions' }
TAsyncPromise >> gtPromiseTreeFor: aView [
	<gtView>
	
	^ aView mondrian
		title: 'Promise Tree';
		priority: 2;
		painting: [ :aMondrian | self gtPaintTreeWith: aMondrian ]
]
