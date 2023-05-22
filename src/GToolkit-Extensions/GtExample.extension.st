Extension { #name : #GtExample }

{ #category : #'*GToolkit-Extensions' }
GtExample >> gtCoderSourceFor: aView [
	<gtView>
	^ aView explicit
		title: 'Source';
		priority: 0;
		stencil: [ (GtPharoMethodCoder forExample: self) asExpandedOnlyElement
				hMatchParent;
				vFitContentLimited ];
		actionButtonIcon: BrGlamorousVectorIcons browse
			action: [ self method browse ]
]
