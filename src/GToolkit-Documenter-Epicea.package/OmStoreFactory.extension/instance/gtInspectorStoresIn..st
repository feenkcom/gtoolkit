*GToolkit-Documenter-Epicea
gtInspectorStoresIn: composite
	<script: 'self current inspect'>
	<gtInspectorPresentationOrder: 1>
	^ composite fastList 
		title: [ 'Stores' translated ];
		display: [ storeByPath associations ];
		when: [ storeByPath notNil ];
		format: [ :anAssoc | 
			anAssoc value 
				ifNil: [ '[released] ', (GtFileUtility shorterNameForFileName: anAssoc key asString) ]
				ifNotNil: [ :theAssoc | 
					GtFileUtility shorterNameForFileName: theAssoc value fileReference ] ];
		send: [ :anAssocOrNil | 
			anAssocOrNil ifNotNil: #value  ];
		yourself