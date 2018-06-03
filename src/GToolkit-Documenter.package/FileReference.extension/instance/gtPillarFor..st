*GToolkit-Documenter
gtPillarFor: aView
	<gtView: 0>
	(#('pier' 'pillar') includes: self extension) ifFalse: [ ^ aView empty ].
	^ aView
		title: 'Pillar';
		stencil: [ 
			GtDocumenter editorForPillar: self ]