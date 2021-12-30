Extension { #name : #GtCoderAst }

{ #category : #'*GToolkit-Extensions' }
GtCoderAst >> gtExploreAstFor: aView [
	<gtView>

	^ aView forward
		title: 'Ast' translated;
		priority: 10;
		object: [ self ast ];
		view: #gtExploreFor:
]

{ #category : #'*GToolkit-Extensions' }
GtCoderAst >> gtSourceStringFor: aView [
	<gtView>

	^ aView forward
		title: 'Source String' translated;
		priority: 11;
		object: [ self sourceString ];
		view: #gtStringFor:;
		actionButtonIcon: BrGlamorousVectorIcons inspect
			tooltip: 'Inspect Source String'
			action: [ :aButton | aButton phlow spawnObject: self sourceString ]
]
