Extension { #name : #ZnHttpUnsuccessful }

{ #category : #'*GToolkit-Extensions' }
ZnHttpUnsuccessful >> gtResponseFor: aView [

	<gtView>
	self response ifNil: [ ^ aView empty ].
	^ aView forward
		  title: 'Response';
		  priority: 3;
		  object: [ self response ];
		  view: #gtResponseFor:;
		  actionButtonIcon: BrGlamorousVectorIcons inspect
		  label: 'Response'
		  tooltip: 'Inspect Zinc response'
		  action: [ :aButton | aButton phlow spawnObject: self response ]
]

{ #category : #'*GToolkit-Extensions' }
ZnHttpUnsuccessful >> gtResponseHeadersFor: aView [

	<gtView>
	self response ifNil: [ ^ aView empty ].
	^ aView forward
		  title: 'Response headers';
		  priority: 4;
		  object: [ self response ];
		  view: #gtHeadersFor:;
		  actionButtonIcon: BrGlamorousVectorIcons inspect
		  label: 'Response'
		  tooltip: 'Inspect Zinc response'
		  action: [ :aButton | aButton phlow spawnObject: self response ]
]

{ #category : #'*GToolkit-Extensions' }
ZnHttpUnsuccessful >> gtResponseTextContentsFor: aView [

	<gtView>
	self response ifNil: [ ^ aView empty ].
	^ aView forward
		  title: 'Response contents';
		  priority: 5;
		  object: [ self response ];
		  view: #gtTextContentsFor:;
		  actionButtonIcon: BrGlamorousVectorIcons inspect
		  label: 'Response'
		  tooltip: 'Inspect Zinc response'
		  action: [ :aButton | aButton phlow spawnObject: self response ]
]
