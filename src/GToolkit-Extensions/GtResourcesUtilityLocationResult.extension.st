Extension { #name : #GtResourcesUtilityLocationResult }

{ #category : #'*GToolkit-Extensions' }
GtResourcesUtilityLocationResult >> gtPathFor: aView [
	<gtView>
	self file ifNil: [ ^ aView empty ].
	^ (self file gtPathFor: aView)
		title: 'Path'
]

{ #category : #'*GToolkit-Extensions' }
GtResourcesUtilityLocationResult >> gtTreeFor: aView [

	<gtView>
	self file ifNil: [ ^ aView empty ].
	^ (self file gtTreeFor: aView) title: 'Tree'
]
