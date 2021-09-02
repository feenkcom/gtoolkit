Extension { #name : 'TAsyncStream' }

{ #category : '*GToolkit-Extensions' }
TAsyncStream >> gtCompositionChildren [

	^ #(  )
]

{ #category : '*GToolkit-Extensions' }
TAsyncStream >> gtCompositionDescription [
	^ self printString
]

{ #category : '*GToolkit-Extensions' }
TAsyncStream >> gtCompositionFor: aView [

	<gtView>
	^ aView columnedTree
		  title: 'Composition';
		  items: [ { self } ];
		  children: #gtCompositionChildren; 
		  expandAll;
		  column: 'Name' text: #gtCompositionDescription;
		  actionUpdateButtonTooltip: 'Update composition tree'
]
