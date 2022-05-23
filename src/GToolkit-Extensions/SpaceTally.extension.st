Extension { #name : #SpaceTally }

{ #category : #'*GToolkit-Extensions' }
SpaceTally >> gtViewItemsFor: aView [
	<gtView>
	results ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Tallies';
		object: [ results ];
		view: #gtViewItemsFor:
]

{ #category : #'*GToolkit-Extensions' }
SpaceTally >> gtViewOverviewFor: aView [
	<gtView>
	results ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Overview';
		object: [ results ];
		view: #gtViewOverviewFor:
]
