Extension { #name : #PharoCommonTools }

{ #category : #'*GToolkit-Extensions' }
PharoCommonTools >> gtRecentToolsFor: aView context: aContext [

	<gtView>
	recentTools ifNil: [ ^ aView empty ].

	aContext at: #gtTreeExpansionLevel put: true.

	^ aView forward
		  title: 'Recent Tools';
		  priority: 2;
		  object: [ recentTools ];
		  view: #gtTreeFor:context:
]

{ #category : #'*GToolkit-Extensions' }
PharoCommonTools >> gtToolsFor: aView context: aContext [

	<gtView>
	tools ifNil: [ ^ aView empty ].
	
	aContext at: #gtTreeExpansionLevel put: true.

	^ aView forward
		  title: 'Tools';
		  priority: 1;
		  object: [ tools ];
		  view: #gtTreeFor:context:
]
