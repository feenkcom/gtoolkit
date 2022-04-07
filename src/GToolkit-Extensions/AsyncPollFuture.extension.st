Extension { #name : #AsyncPollFuture }

{ #category : #'*GToolkit-Extensions' }
AsyncPollFuture >> gtCompositionDescription [

	^ self printString asRopedText
		  append: ': ' asRopedText;
		  append: ((pollBlock ifNil: [ executedBlock ]) printString asRopedText foreground:
					   BrGlamorousColors disabledButtonTextColor)
]

{ #category : #'*GToolkit-Extensions' }
AsyncPollFuture >> gtViewExecutedBlockFor: aView [
	<gtView>
	executedBlock ifNil: [ ^ aView empty ].
	
	^ aView forward 
		title: 'Executed Block';
		object: [ executedBlock ];
		view: #gtSourceCodeFor:
]
