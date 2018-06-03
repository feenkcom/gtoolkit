*GToolkit-Documenter
gtInspectorPillarWithBlocIn: composite
	<gtInspectorPresentationOrder: -1>
	^ composite bloc
		title: '_Pillar';
		element: [ 
			| element |
			element := (GtDocumenter editorForPillar: self).
			element
				addShortcut: (BlShortcut new
					combination: (BlKeyCombination builder meta; key: Key v; build);
					action: [ element contentElement editor insertString: Clipboard clipboardText asString at: element contentElement editor cursor position ]) ];
		act: [ :bloc |
				self ensureDelete; writeStreamDo: [ :s | s nextPutAll: bloc element contentElement editor text asString ] ]
				icon: GLMUIThemeExtraIcons glamorousSave
				on: $s
				entitled: 'Save';
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
		when: [ 
			self exists and: [
				#('pier' 'pillar') includes: self extension ] ] 