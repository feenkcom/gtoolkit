gt-inspector-extension
gtInspectorBindingsIn: composite
	<gtInspectorPresentationOrder: 1>
	^ (bindings gtInspectorItemsIn: composite)
			title: [ 'Bindings' translated ];
			display: [ bindings values ];
			send: [ :aCollectionOrNil | 
				(aCollectionOrNil ifNotNil: [ :aCollection |
					aCollection collect: #value ]) gtInspectorInterestingObject ]