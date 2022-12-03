Extension { #name : #NeoJSONReader }

{ #category : #'*GToolkit-Extensions' }
NeoJSONReader >> gtViewMappingsFor: aView [ 
	<gtView>
	
	^ aView columnedList 
		title: 'Mappings';
		items: [ 
			mappings 
				ifNil: [ #() ]
				ifNotNil: [ mappings associations] ];
		column: 'Name' text: [ :assoc | assoc key ];
		column: 'Type' text: [ :assoc | assoc value className ];
		send: [ :assoc | assoc value ]
]
