Extension { #name : #GtTextualCoderAddOns }

{ #category : #'*GToolkit-Extensions' }
GtTextualCoderAddOns >> gtExploreAstFor: aView [
	<gtView>
	^ aView forward
		title: 'Ast' translated;
		priority: 40;
		object: [ self ast ];
		view: #gtExploreAstFor:;
		actionButtonIcon: BrGlamorousVectorIcons inspect
			tooltip: 'Inspect AST'
			action: [ :aButton | aButton phlow spawnObject: self ast ]
]

{ #category : #'*GToolkit-Extensions' }
GtTextualCoderAddOns >> gtViewStylersFor: aView [
	<gtView>
	^ aView list
		title: 'Stylers' translated;
		priority: 30;
		items: [ self stylers ]
]
