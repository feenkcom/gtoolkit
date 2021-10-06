Extension { #name : #GtSearchFilter }

{ #category : #'*GToolkit-Extensions' }
GtSearchFilter >> children [
	<return: #Collection of: #GtSearchFilter>
	^ Array empty
]

{ #category : #'*GToolkit-Extensions' }
GtSearchFilter >> gtHierarchyFor: aView [
	<gtView>
	^ aView tree
		title: 'Hierarchy';
		priority: 80;
		items: [ { self } ];
		children: [ :aFilter | aFilter children ];
		expandUpTo: 2
]

{ #category : #'*GToolkit-Extensions' }
GtSearchFilter >> gtMetricsFor: aView [

	<gtView>
	^ aView forward
		  title: 'Metrics';
		  priority: 11;
		  object: [ self result ];
		  view: #gtMetricsFor:
]
