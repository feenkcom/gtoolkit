*GToolkit-Documenter
gtInspectorRopeTreeIn: composite
	<gtInspectorPresentationOrder: 40>
	self rope ifNotNil: [ 
		(self rope gtInspectorTreeIn: composite)
			title: 'Rope tree' ]