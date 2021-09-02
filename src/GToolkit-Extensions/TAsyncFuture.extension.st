Extension { #name : 'TAsyncFuture' }

{ #category : '*GToolkit-Extensions' }
TAsyncFuture >> gtCompositionChildren [

	^ #(  )
]

{ #category : '*GToolkit-Extensions' }
TAsyncFuture >> gtCompositionDescription [
	^ self printString
]

{ #category : '*GToolkit-Extensions' }
TAsyncFuture >> gtCompositionFor: aView [

	<gtView>
	^ aView columnedTree
		  title: 'Composition';
		  items: [ { self } ];
		  children: #gtCompositionChildren;
		  expandAll;
		  column: 'Name' item: #gtCompositionDescription
]
