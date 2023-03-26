Extension { #name : #AsyncObservableValue }

{ #category : #'*GToolkit-Extensions' }
AsyncObservableValue >> gtCompositionChildren [

	^ stream
		  ifNotNil: [ :aStream | 
			  aStream == self
				  ifFalse: [ { aStream }, (sinks asArray reject: #isNil) ]
				  ifTrue: [ sinks asArray reject: #isNil ] ]
		  ifNil: [ sinks asArray reject: #isNil ]
]

{ #category : #'*GToolkit-Extensions' }
AsyncObservableValue >> gtCompositionDescription [
	^ self printString asRopedText
		  appendString: ': ';
		  append: ((sinks asArray reject: #isNil) size asRopedText foreground: BrGlamorousColors disabledButtonTextColor);
		  append: (' observers, ' asRopedText foreground: BrGlamorousColors disabledButtonTextColor);
		  append: ('value=' asRopedText foreground: BrGlamorousColors disabledButtonTextColor);
		  append: (self valueOrNil printString asRopedText foreground: BrGlamorousColors disabledButtonTextColor)
]

{ #category : #'*GToolkit-Extensions' }
AsyncObservableValue >> gtLiveFor: aView [
	<gtView>

	^ aView explicit
		title: 'Live';
		priority: 5;
		stencil: [
			BrHorizontalPane new
				id: #gtLiveFor:;
				matchParent;
				
				withAsyncSinkDo: [ :anElementSink |
					anElementSink
						sink: AsyncPeekSink new;
						whenUpdate: [ :anElement :aSink | 
							anElement removeChildren.
							aSink peek
								ifSome: [ :aValue | anElement addChild: (GtInspector forObject: aValue) ]
								ifNone: [  ] ].
					self observe: anElementSink ] ]
]
