*GToolkit-Documenter
gtInspectorPillarCommentWithBlocIn: composite
	<gtInspectorPresentationOrder: 40>
	^ composite bloc
		title: 'Comment (Bloc)';
		element: [ GtDocumenter editorForText: self comment ]