Extension { #name : #NeoJSONCustomMapping }

{ #category : #'*GToolkit-Extensions' }
NeoJSONCustomMapping >> gtViewReaderSourceCodeFor: aView [
	<gtView>
	
	^ aView forward
		title: 'Reader Coder';
		priority: 1;
		object: [ reader ];
		view: #gtSourceCodeFor:;
		actionButtonIcon: BrGlamorousIcons inspect 
			tooltip: 'Inspect Block' 
			action: [ :aButton | 
				aButton phlow spawnObject: self ]
]

{ #category : #'*GToolkit-Extensions' }
NeoJSONCustomMapping >> gtViewWriterSourceCodeFor: aView [
	<gtView>
	
	^ aView forward
		title: 'Writer Coder';
		priority: 10;
		object: [ writer ];
		view: #gtSourceCodeFor:;
		actionButtonIcon: BrGlamorousIcons inspect 
			tooltip: 'Inspect Block' 
			action: [ :aButton | 
				aButton phlow spawnObject: self ]
]
