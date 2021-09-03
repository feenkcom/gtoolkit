Extension { #name : 'BrTextEditorCompositeMemento' }

{ #category : '*GToolkit-Extensions' }
BrTextEditorCompositeMemento >> gtMementosFor: aView [
	<gtView>
	self mementos ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Mementos';
		items: [ self mementos ];
		column: 'Label' text: #label weight: 0.5;
		column: 'Value' text: #value
]
