Extension { #name : #RGBehavior }

{ #category : #'*GToolkit-Extensions' }
RGBehavior >> gtLocalMethodsFor: aView [
	<gtView>
	
	^ aView list
		title: 'Local methods';
		priority: 10;
		items: [ self localMethods sorted: [ :a :b | a name < b name ] ];
		itemText: [ :eachMethod | eachMethod name ]
]
