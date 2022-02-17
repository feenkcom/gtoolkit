Extension { #name : #GtResourcesUtilityLocation }

{ #category : #'*GToolkit-Extensions' }
GtResourcesUtilityLocation >> gtLocationFor: aView [

	<gtView>
	^ aView forward
		  title: 'Location';
		  priority: 1;
		  object: [ self resourceAtPath: Path * '.' ];
		  view: #gtPathFor:
]

{ #category : #'*GToolkit-Extensions' }
GtResourcesUtilityLocation >> gtPathExampleFor: aView [

	<gtView>
	^ aView forward
		  title: 'Example';
		  priority: 15;
		  object: [ self resourceAtPath: Path * 'subdirectory' / 'file.txt' ];
		  view: #gtPathFor:
]

{ #category : #'*GToolkit-Extensions' }
GtResourcesUtilityLocation >> gtTreeFor: aView [

	<gtView>
	^ aView forward
		  title: 'Files';
		  priority: 10;
		  object: [ self resourceAtPath: Path * '.' ];
		  view: #gtTreeFor:
]
