*GToolkit-Documenter
gtInspectorTreeIn: composite
	<gtInspectorPresentationOrder: 10>
	^ composite blocMondrian
		title: 'Tree';
		painting: [ :view :x :presentation |
			view nodes
				shape: [ :each | 
					(each isKindOf: BrCollectionRope)
						ifTrue: [
							BlTextElement new 
								text: each asString asRopedText;
								when: BlClickEvent do: [ presentation selection: each ] ]
						ifFalse: [ 
							BlElement new 
								geometry: BlEllipse new;
								border: (BlBorder paint: Color gray width: 2);
								size: 10@10;
								when: BlClickEvent do: [ presentation selection: each ] ] ];
				with: (self withDeepCollect: #children).
			view edges
				fromNearestCircle;
				toCenterTop;
				connectToAll: #children.
			view layout tree horizontalGap: 20 ]