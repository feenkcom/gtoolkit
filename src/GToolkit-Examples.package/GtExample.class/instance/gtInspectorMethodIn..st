GT-Examples-UI
gtInspectorMethodIn: composite
	<gtInspectorPresentationOrder: 0>
	self exists ifFalse: [ ^ self ].
	^ (self method gtInspectorSourceIn: composite)
		title: 'Method'