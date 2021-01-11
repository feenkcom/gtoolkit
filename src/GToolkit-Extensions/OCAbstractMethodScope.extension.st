Extension { #name : #OCAbstractMethodScope }

{ #category : #'*GToolkit-Extensions' }
OCAbstractMethodScope >> gtAllTempsFor: aView [
	<gtView>
	^ aView columnedList
		title: 'All Temps';
		tooltip: 'All Temporary Variables';
		priority: 1;
		items: [ self allTemps ];
		column: 'Variable' item: #yourself
]
