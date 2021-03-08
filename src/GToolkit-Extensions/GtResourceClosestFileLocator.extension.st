Extension { #name : #GtResourceClosestFileLocator }

{ #category : #'*GToolkit-Extensions' }
GtResourceClosestFileLocator >> gtOverviewFor: aView [
	<gtView>
	self file ifNil: [ ^ aView empty ].
	
	^ aView columnedList
		title: 'Overview';
		priority: 1;
		items: [
			{
				'Original file' -> self file.
				'Closest FileLocator parent' -> self closestParent.
				'Transformed file' -> self transform
			} ];
		column: 'Name' item: #key width: 160;
		column: 'Value' item: #value
]
