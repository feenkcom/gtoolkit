Extension { #name : #BrElementUpdater }

{ #category : #'*GToolkit-Extensions' }
BrElementUpdater >> gtActionMethodFor: aView [
	<gtView>
	| aSelector |
	(self action respondsTo: #gtMethodFor:) ifTrue: [ aSelector := #gtMethodFor: ].
	(self action respondsTo: #gtSourceCodeFor:)
		ifTrue: [ aSelector := #gtSourceCodeFor: ].

	aSelector ifNil: [ ^ aView empty ].


	^ aView forward
		title: 'Updating Method';
		object: [ self action ];
		view: aSelector
]
