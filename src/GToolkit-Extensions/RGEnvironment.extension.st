Extension { #name : #RGEnvironment }

{ #category : #'*GToolkit-Extensions' }
RGEnvironment >> gtBehaviorsFor: aView [
	<gtView>
	
	^ aView list
		title: 'Behaviors';
		priority: 11;
		items: [ self ask behaviors sorted: [ :a :b | a name < b name ] ];
		itemText: [ :eachBehavior | eachBehavior name ]
]

{ #category : #'*GToolkit-Extensions' }
RGEnvironment >> gtPackagesFor: aView [
	<gtView>
	
	^ aView list
		title: 'Packages';
		priority: 10;
		items: [ self ask packages sorted: [ :a :b | a name < b name ] ];
		itemText: [ :eachPackage | eachPackage name ]
]
