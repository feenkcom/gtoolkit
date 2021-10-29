Extension { #name : #PragmaCollector }

{ #category : #'*GToolkit-Extensions' }
PragmaCollector >> gtCollectedFor: aView [

	<gtView>
	^ aView list
		  title: 'Pragmas';
		  priority: 1;
		  items: [ self collected ifNil: [ #(  ) ] ];
		  updateWhen: PragmaCollectorReset, PragmaAnnouncement in: self announcer;
		  actionButtonIcon: BrGlamorousVectorIcons refresh
		  label: 'Collect'
		  tooltip: 'Collect existing pragmas'
		  action: [ :aButton | 
			  self reset.
			  aButton phlow fireUpdateWish ]
]
