*GToolkit-Documenter
gtInspectorPillarCommentWithBlocIn: composite
	<gtInspectorPresentationOrder: 19>
	^ composite bloc
		title: '_Comment';
		element: [ GtDocumenter editorForText: self comment ]