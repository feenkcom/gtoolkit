Extension { #name : #BrTextStylerAsyncStrategySignal }

{ #category : #'*GToolkit-Extensions' }
BrTextStylerAsyncStrategySignal >> gtElementPreviewFor: aView [
	<gtView>
	^ aView forward
		title: 'Element';
		priority: 0;
		object: [ self element ];
		view: #gtLiveFor:
]
