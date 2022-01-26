Extension { #name : #GtVirtualMachine }

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
