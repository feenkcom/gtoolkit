*GToolkit-Documenter
gtInspectorTreeIn: composite
	<gtInspectorPresentationOrder: 10>
	composite blocMondrian
		title: 'Tree';
		painting: [ :view |
			view nodes
				shape: [ :each | 
					(each isKindOf: BrCollectionRope)
						ifTrue: [
							BlTextElement new 
								text: each asString asRopedText ]
						ifFalse: [ 
							BlElement new 
								geometry: BlEllipse new;
								border: (BlBorder paint: Color gray width: 2);
								size: 10@10 ] ];
				with: (self withDeepCollect: #children).
			view edges
				fromCenterBottom;
				toCenterTop;
				connectToAll: #children.
			view layout tree horizontalGap: 20 ]