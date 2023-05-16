Extension { #name : #BlDevScripterAssertionFailure }

{ #category : #'*GToolkit-Extensions' }
BlDevScripterAssertionFailure >> gtStepsTreeFor: aView [
	<gtView>
	self scripter ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Steps in tree';
		priority: 9;
		object: [ self scripter ];
		view: #gtStepsTreeFor:
]
