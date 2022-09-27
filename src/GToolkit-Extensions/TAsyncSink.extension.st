Extension { #name : #TAsyncSink }

{ #category : #'*Gtoolkit-Extensions' }
TAsyncSink >> gtCompositionChildren [
	^ #()
]

{ #category : #'*Gtoolkit-Extensions' }
TAsyncSink >> gtCompositionDescription [
	^ self printString
]

{ #category : #'*Gtoolkit-Extensions' }
TAsyncSink >> gtCompositionFor: aView [
	<gtView>
	^ aView columnedTree
		title: 'Composition';
		items: [ {self} ];
		children: #gtCompositionChildren;
		expandAll;
		column: 'Name' text: #gtCompositionDescription;
		actionUpdateButtonTooltip: 'Update composition tree'
]
