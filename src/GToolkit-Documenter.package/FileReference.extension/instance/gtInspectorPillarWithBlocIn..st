*GToolkit-Documenter
gtInspectorPillarWithBlocIn: composite
	<gtInspectorPresentationOrder: 40>
	^ composite bloc
		title: 'Bloc Pillar';
		element: [ GtDocumenter editorForPillar: self ];
		when: [ #('pier' 'pillar') includes: self extension ]