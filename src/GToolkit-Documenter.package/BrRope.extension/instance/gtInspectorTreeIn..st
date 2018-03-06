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
								zIndex: 10;
								background: Color white;
								constraintsDo: [ :c | c padding: (BlInsets all: 5) ];
								text: each asString asRopedText;
								when: BlClickEvent do: [ presentation selection: each ] ]
						ifFalse: [
							BlElement new 
								zIndex: 10;
								geometry: BlEllipse new;
								border: (BlBorder paint: Color black width: 1);
								in: [ :anElement |
									(each isKindOf: BrAttributeRope)
										ifTrue: [ anElement background: Color orange ]
										ifFalse: [ anElement background: Color white ] ];
								size: 10@10;
								when: BlClickEvent do: [ presentation selection: each ] ] ];
				with: (self withDeepCollect: #children).
			view edges
				shape: [ :each | BlLineElement new border: (BlBorder paint: (Color gray alpha: 0.5) width: 1 ) ];
				connectToAll: #children.
			view layout horizontalTree 
				horizontalGap: 30;
				verticalGap: 10 ]