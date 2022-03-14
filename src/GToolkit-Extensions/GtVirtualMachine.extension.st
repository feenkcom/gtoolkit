Extension { #name : #GtVirtualMachine }

{ #category : #'*GToolkit-Extensions' }
GtVirtualMachine >> gtEnabledSignals: aView [
	<gtView>
	
	^ aView list
		priority: 2;
		title: 'Enabled signals';
		items: [ self enabledSignals ]
]

{ #category : #'*GToolkit-Extensions' }
GtVirtualMachine >> gtNamedPrimitives: aView [
	<gtView>
	
	^ aView columnedList
		priority: 2;
		title: 'Named primitives';
		items: [ self namedPrimitives ];
		column: 'Primitive' text: [ :each | each primitive ];
		column: 'Plugin' text: [ :each | each plugin ifEmpty: [ 'internal' asRopedText italic ] ]
]
