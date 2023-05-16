Extension { #name : #GtPharoTestSuiteViewModel }

{ #category : #'*GToolkit-Extensions' }
GtPharoTestSuiteViewModel >> gtLiveFor: aView [
	<gtView>
	self hasPharoTestSuite ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Test cases';
		priority: 1;
		object: [ self pharoTestSuite ];
		view: #gtLiveFor:
]
