Extension { #name : #SmaCCParser }

{ #category : #'*GToolkit-Extensions' }
SmaCCParser >> gtScannerStreamStateFor: aView [
	<gtView>
	self scanner ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Stream';
		object: [ self scanner ];
		view: #gtStreamStateFor:
]

{ #category : #'*GToolkit-Extensions' }
SmaCCParser class >> gtStylersFor: aView [
	<gtView>
	<gtClassView>
	| someStylers |
	self name = #SmaCCParser ifTrue: [ ^ aView empty ].
	self name = #SmaCCGLRParser ifTrue: [ ^ aView empty ].
	someStylers := self gtStylers ifNil: [ ^ aView empty ].
	someStylers ifEmpty: [ ^ aView empty ].

	^ aView columnedList
		title: 'Stylers';
		items: [ self gtStylers ];
		column: 'Name' text: #yourself;
		column: 'Number of Rules' text: [ :aStyler | aStyler stylerRules size ]
]
