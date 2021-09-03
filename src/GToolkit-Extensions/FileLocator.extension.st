Extension { #name : 'FileLocator' }

{ #category : '*GToolkit-Extensions' }
FileLocator class >> gtPredefinedOriginsFor: aView [
	<gtView>
	<gtClassView>
	^ aView columnedList
		title: 'Predefined origins';
		items: [ self gtLocations sort: [ :a :b | 
			a origin < b origin ] ];
		column: 'Selector' translated text: [ :e | e origin ];
		column: 'Location' translated text: [ :e | e resolve ] weight: 2
]
