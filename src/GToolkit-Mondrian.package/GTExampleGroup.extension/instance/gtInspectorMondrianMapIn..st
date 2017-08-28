*GToolkit-Mondrian
gtInspectorMondrianMapIn: composite
	<gtInspectorPresentationOrder: 40>
	composite bloc
		title: 'Map (Bloc)';
		element: [ :bloc |
			| view |
			view := GtMondrian new. 
			view shape: [ :each | 
				BlElement new 
					border: (BlBorder paint: Color lightGray width: 2);
					constraintsDo: [ :constraints |
							constraints padding: (BlInsets all: 20) ] ].
			view nodes: (self examples groupedBy: #methodClass) associations forEach: [ :assoc | 
				view shape: [ :each |
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
					editorElement editor: editor ].
				view nodes: assoc value.
				view layout: (GtGraphTreeLayout new verticalGap: 100) ].
			view shape: [ :each | 
				BlLineElement new
					border: (BlBorder paint: (Color gray alpha: 0.2) width: 1)  ].
			view edges connect: self examples fromAll: #directDependents to: #yourself.
			view layout: GtGraphGridLayout new.
			view asScalableElement ]