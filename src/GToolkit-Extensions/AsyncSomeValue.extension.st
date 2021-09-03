Extension { #name : 'AsyncSomeValue' }

{ #category : '*GToolkit-Extensions' }
AsyncSomeValue >> gtCompositionChildren [

	(self value class isComposedBy: TAsyncFuture) ifTrue: [ 
		^ { self value } ].
	(self value class isComposedBy: TAsyncStream) ifTrue: [ 
		^ { self value } ].
	^ #(  )
]

{ #category : '*GToolkit-Extensions' }
AsyncSomeValue >> gtCompositionDescription [

	^ self printString asRopedText
		  append: ': ' asRopedText;
		  append: ('value=' asRopedText foreground:
					   BrGlamorousColors disabledButtonTextColor);
		  append: (self value printString asRopedText foreground:
					   BrGlamorousColors disabledButtonTextColor)
]

{ #category : '*GToolkit-Extensions' }
AsyncSomeValue >> gtCompositionFor: aView [

	<gtView>
	^ aView columnedTree
		  title: 'Composition';
		  items: [ { self } ];
		  children: #gtCompositionChildren; 
		  expandAll;
		  column: 'Name' item: #gtCompositionDescription;
		  actionUpdateButtonTooltip: 'Update composition tree'
]

{ #category : '*GToolkit-Extensions' }
AsyncSomeValue >> gtLiveFor: aView [
	^ self gtCompositionFor: aView
]
