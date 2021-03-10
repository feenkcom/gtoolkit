Extension { #name : #GtCoderNavigationPackagesTagsClassesModel }

{ #category : #'*GToolkit-Extensions' }
GtCoderNavigationPackagesTagsClassesModel >> gtLiveFor: aView [
	<gtView>
	coder ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Live';
		priority: 1;
		object: [ coder ];
		view: #gtLiveFor:
]
