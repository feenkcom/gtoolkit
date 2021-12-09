Extension { #name : #RGMethod }

{ #category : #'*GToolkit-Extensions' }
RGMethod >> gtSourceFor: aView [
	<gtView>

	^ aView explicit
		title: 'Source';
		priority: 10;
		actionButtonIcon: BrGlamorousVectorIcons browse
			tooltip: 'Browse method'
			action: [ self gtBrowse ];
		stencil: [
			(GtPharoMethodCoder forRingMethod: self)
				asExpandedOnlyElement
				vFitContentLimited ]
]
