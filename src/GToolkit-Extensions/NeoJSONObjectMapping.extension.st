Extension { #name : #NeoJSONObjectMapping }

{ #category : #'*GToolkit-Extensions' }
NeoJSONObjectMapping >> gtViewPropertiesFor: aView [ 
	<gtView>
	
	^ aView columnedList 
		title: 'Properties';
		items: [ 
			properties ifNil: [ #() ] ];
		column: 'Name' text: [ :aPropertyMapping | 
			aPropertyMapping propertyName ];
		column: 'Schema' text: [ :aPropertyMapping | 
			aPropertyMapping readSlotNamed: #valueSchema ]
]
