gt-inspector-extension
gtInspectorOutsIn: composite
	<gtInspectorPresentationOrder: -4>
	^ self document ifNotNil: [ :aDocument | 
		aDocument outs gtInspectorCodeSnippetsIn: composite ]