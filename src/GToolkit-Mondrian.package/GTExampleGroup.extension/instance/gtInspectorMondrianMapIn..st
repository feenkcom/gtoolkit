*GToolkit-Mondrian
gtInspectorMondrianMapIn: composite
	<gtInspectorPresentationOrder: 40>
	composite bloc
		title: 'Map (Bloc)';
		element: [ :bloc |
			| view |
			view := GtMondrian new. 
			view nodes
				shape: [ :each | 
					BlElement new 
						border: (BlBorder paint: Color lightGray width: 2);
						constraintsDo: [ :constraints |
							constraints padding: (BlInsets all: 20) ] ];
				with: (self examples groupedBy: #methodClass) associations forEach: [ :assoc | 
				view nodes
					shape: [ :each |
						| text styler editor editorElement |
						"BlElement new 	
							geometry: BlEllipse new;
							border: (BlBorder paint: Color black width: 2);
							size: 20@20;
							constraintsDo: [ :constraints |
								constraints padding: (BlInsets all: 10) ];
							 addEventHandlerOn: BlMouseDownEvent do: [ :anEvent | bloc selection: each ]	"
						text := BrRopedText string: each method sourceCode.
						text attributes: { (BrFontSizeAttribute size: 10) beNotOverwritableByStyler. BrFontGenericFamilyAttribute monospace beNotOverwritableByStyler}.
						styler := BrRBTextStyler new classOrMetaClass: each methodClass.
						editor := BrTextEditor new.
						editor styler: styler.
						editor text: text.
						editorElement := BrEditorElement new.
						editorElement constraintsDo: [ :c |
						    c horizontal exact: 200.
						    c vertical fitContent ].
						editorElement editor: editor ];
					with: assoc value.
				view layout custom: (GtGraphTreeLayout new verticalGap: 100) ].
			view edges 
				shape: [ :each | 
					BlLineElement new
						border: (BlBorder paint: (Color gray alpha: 0.2) width: 1) ];
				connect: self examples from: #yourself toAll: #dependenciesOrArguments.
			view layout custom: GtGraphGridLayout new.
			view asScalableElement ]