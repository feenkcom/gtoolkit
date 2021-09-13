Extension { #name : 'ZnServer' }

{ #category : '*GToolkit-Extensions' }
ZnServer >> gtDelegateFor: aView [

	<gtView>
	self optionAt: #delegate ifAbsent: [ ^ aView empty ].
	(self delegate respondsTo: #gtDelegateFor:) ifFalse: [ ^ aView empty ].
	^ aView forward
		  title: 'Delegate';
		  object: [ self delegate ];
		  view: #gtDelegateFor:;
		  actionButtonIcon: BrGlamorousVectorIcons inspect
		  label: 'Delegate'
		  tooltip: 'Inspect delegate'
		  action: [ :aButton | aButton phlow spawnObject: self delegate ]
]
