*GToolkit-Documenter
gtInspectorPillarWithBlocIn: composite
	<gtInspectorPresentationOrder: -1>
	^ composite bloc
		title: '_Pillar';
		element: [ GtDocumenter editorForPillar: self ];
		act: [ :aBlocPresentation | aBlocPresentation element zoomIn ]
			icon: GLMUIThemeExtraIcons glamorousZoomIn
			entitled: 'Zoom in';
		act: [ :aBlocPresentation | aBlocPresentation element zoomOut ]
			icon: GLMUIThemeExtraIcons glamorousZoomOut
			entitled: 'Zoom out';
		act: [ :aBlocPresentation | aBlocPresentation element zoomReset ]
			icon: GLMUIThemeExtraIcons glamorousZoomToFit
			entitled: 'Zoom reset';
		act: [ :aBlocPresentation | aBlocPresentation element contentElement editor inspect ]
			icon: GLMUIThemeExtraIcons glamorousInspect
			entitled: 'Inspect'; 
		when: [ #('pier' 'pillar') includes: self extension ]