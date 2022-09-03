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
		column: 'Compiled Method' text: #key;
		column: ''
			stencil: [ :anAssoc | 
				| isLatest |
				isLatest := anAssoc key second methodClass methodDict
						at: anAssoc key second selector
						ifPresent: [ :aMethod | aMethod == anAssoc key second ]
						ifAbsent: [ false ].

				BlElement new
					size: 13 @ 13;
					geometry: BlCircleGeometry new;
					background: (isLatest
							ifTrue: [ BrGlamorousColors successBackgroundColor ]
							ifFalse: [ BrGlamorousColors errorBackgroundColor ]);
					aptitude: (BrGlamorousWithLabelTooltipAptitude new
							text: (isLatest ifTrue: [ 'The current method' ] ifFalse: [ 'An old method version' ])) ]
			width: 20;
		column: ''
			stencil: [ :anAssoc | 
				BrButton new
					aptitude: BrGlamorousButtonWithIconAptitude;
					fitContent;
					beTinySize;
					icon: BrGlamorousVectorIcons inspect;
					label: 'Inspect compiled method';
					action: [ :aButton | aButton phlow spawnObject: anAssoc key ] ]
			width: 35;
		column: 'Example With Result' text: #value;
		column: ''
			stencil: [ :anAssoc | 
				BlElement new
					size: 13 @ 13;
					geometry: BlCircleGeometry new;
					background: anAssoc value color;
					aptitude: (BrGlamorousWithLabelTooltipAptitude new text: 'Example execution result') ]
			width: 20;
		column: ''
			stencil: [ :anAssoc | 
				BrButton new
					aptitude: BrGlamorousButtonWithIconAptitude;
					fitContent;
					beTinySize;
					icon: BrGlamorousVectorIcons inspect;
					label: 'Inspect example with result';
					action: [ :aButton | aButton phlow spawnObject: anAssoc value ] ]
			width: 35;
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
		column: 'Number'
			text: [ :_ :anIndex | anIndex ]
			width: 50;
		column: 'Example With Result' text: #yourself;
		column: 'Result'
			stencil: [ :anExample | 
				BlElement new
					size: 13 @ 13;
					geometry: BlCircleGeometry new;
					background: anExample color;
					aptitude: (BrGlamorousWithLabelTooltipAptitude new text: 'Example execution result') ]
			width: 40;
		actionUpdateButton
]
