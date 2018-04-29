*GToolkit-Documenter
gtInspectorBlocCodeGraphIn: composite
	<gtInspectorPresentationOrder: 40>
	composite blocMondrian
		title: '_Code graph';
		painting: [ :view :x :presentation |
			view nodes 
				shape: [ :each | 
					| text styler editor editorElement |
					text := BrRopedText string: each method sourceCode.
					styler := GtExamplesStyler new classOrMetaClass: each methodClass.
					editor := BrTextEditor new.
					editor styler: styler.
					editor text: text.
					editorElement := BrEditorElement new.
					editorElement constraintsDo: [ :c |
					    c horizontal matchParent.
					    c vertical matchParent ].
					editorElement editor: editor.
					editorElement
						addEventHandlerOn: BlClickEvent do: [ :anEvent | presentation selection: each ].
					editorElement ];
				with: (self withDeepCollect: #directDependencies) asSet.
			view edges 
				fromRightCenter; toLeftCenter;
				connectToAll: #directDependencies.
			view layout horizontalDominanceTree layered horizontalGap: 100 ]