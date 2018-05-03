gt-inspector-extension
gtInspectorBindingsTreeIn: composite
	<gtInspectorPresentationOrder: 5>
	^ composite fastTree
		title: [ 'Bindings tree' ];
		display: [ { self } ];
		children: [ :anItem | 
			anItem 
				ifNil: [ #() ] 
				ifNotNil: [ { anItem bindings } ] ];
		yourself