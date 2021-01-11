Extension { #name : #OCAbstractScope }

{ #category : #'*GToolkit-Extensions' }
OCAbstractScope >> gtOuterScopesFor: aView [
	<gtView>
	outerScope ifNil: [ ^ aView empty ].
	^ aView columnedTree
		title: 'Outer Scopes';
		priority: 5;
		items: [ { self } ];
		children: [ :aScope | 
			aScope outerScope 
				ifNil: #() 
				ifNotNil: [ :anOuterScope |
					anOuterScope asArray ] ];
		expandAll;
		column: 'Scope' item: #value
]
