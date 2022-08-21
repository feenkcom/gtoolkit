Extension { #name : #GtPharoExampleSuite }

{ #category : #'*GToolkit-Extensions' }
GtPharoExampleSuite >> gtExamplesWithResultCacheFor: aView [
	<gtView>
	examplesWithResultCache ifNil: [ ^ aView empty ].

	^ aView columnedList
		title: 'Examples With Result Cache';
		priority: 1;
		items: [ Array
				streamContents: [ :aStream | 
					examplesWithResultCache
						keysAndValuesDo: [ :aKey :aValue | aStream nextPut: aKey -> aValue ] ] ];
		column: ''
			text: [ :_ :anIndex | anIndex ]
			width: 40;
		column: 'Key'
			stencil: [ :anAssoc | 
				BrButton new
					aptitude: BrGlamorousButtonWithIconAptitude;
					fitContent;
					beTinySize;
					icon: BrGlamorousVectorIcons inspect;
					label: 'Inspect key';
					action: [ :aButton | aButton phlow spawnObject: anAssoc key ] ]
			width: 35;
		column: '' text: #key;
		column: 'Value'
			stencil: [ :anAssoc | 
				BrButton new
					aptitude: BrGlamorousButtonWithIconAptitude;
					fitContent;
					beTinySize;
					icon: BrGlamorousVectorIcons inspect;
					label: 'Inspect value';
					action: [ :aButton | aButton phlow spawnObject: anAssoc value ] ]
			width: 35;
		column: '' text: #value;
		column: 'Result' stencil: [ :anAssoc | anAssoc value icon ] width: 40;
		updateWhen: GtPharoSuiteStreamChanged in: [ self announcer ];
		send: #value;
		actionUpdateButton
]

{ #category : #'*GToolkit-Extensions' }
GtPharoExampleSuite >> gtExamplesWithResultStreamFor: aView [
	<gtView>
	examplesWithResultStream ifNil: [ ^ aView empty ].

	^ aView columnedList
		title: 'Examples With Result Stream';
		priority: 2;
		items: [ examplesWithResultStream asyncSimilarCopy ];
		column: 'Number' text: [ :_ :anIndex | anIndex ] width: 50;
		column: 'Name' text: #yourself;
		column: 'Result' stencil: [ :anAssoc | anAssoc value icon ] width: 40;
		updateWhen: GtPharoSuiteStreamChanged in: [ self announcer ];
		actionUpdateButton
]
