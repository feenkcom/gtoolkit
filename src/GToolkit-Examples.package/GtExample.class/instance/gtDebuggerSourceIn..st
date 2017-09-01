GT-Examples-UI
gtDebuggerSourceIn: composite
	<gtDebuggerPresentationOrder: 1>
	self exists ifFalse: [ ^ self ].
	^ (self method gtInspectorSourceIn: composite)
		title: 'Method'