*GToolkit-Documenter
gtInspectorTextIn: composite
	<gtInspectorPresentationOrder: -10>  
	 composite bloc
		title: 'Text';
		element: [
			| root |
			root := BlElement new.
			root constraintsDo: [ :c | 
					c vertical matchParent. 
					c horizontal matchParent ]. 
			self gtTextIn: root.
			root ];
		act: [ :aBlocPresentation | aBlocPresentation element children first zoomIn ]
			icon: GLMUIThemeExtraIcons glamorousZoomIn
			entitled: 'Zoom in';
		act: [ :aBlocPresentation | aBlocPresentation element children first zoomOut ]
			icon: GLMUIThemeExtraIcons glamorousZoomOut
			entitled: 'Zoom out';
		act: [ :aBlocPresentation | aBlocPresentation element children first zoomReset ]
			icon: GLMUIThemeExtraIcons glamorousZoomToFit
			entitled: 'Zoom reset';
		act: [ :aBlocPresentation | aBlocPresentation element children first contentElement editor inspect ]
			icon: GLMUIThemeExtraIcons glamorousInspect
			entitled: 'Inspect'