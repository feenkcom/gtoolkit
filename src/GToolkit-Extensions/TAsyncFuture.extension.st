Extension { #name : #TAsyncFuture }

{ #category : #'*GToolkit-Extensions' }
TAsyncFuture >> gtCompositionChildren [

	^ #(  )
]

{ #category : #'*GToolkit-Extensions' }
TAsyncFuture >> gtCompositionDescription [
	^ self printString
]

{ #category : #'*GToolkit-Extensions' }
TAsyncFuture >> gtCompositionFor: aView [

	<gtView>
	^ aView columnedTree
		  title: 'Composition';
		  items: [ { self } ];
		  children: #gtCompositionChildren;
		  expandAll;
		  column: 'Name' text: #gtCompositionDescription;
		  actionUpdateButtonTooltip: 'Update composition tree'
]

{ #category : #'*GToolkit-Extensions' }
TAsyncFuture >> gtExecuteActionFor: anAction [
	<gtAction>
	
	^ anAction button
		icon: BrGlamorousVectorIcons playinspect;
		tooltip: 'Convert to promise and inspect';
		priority: 10;
		action: [ :aButton | aButton phlow spawnObject: self asAsyncPromise ]
]
