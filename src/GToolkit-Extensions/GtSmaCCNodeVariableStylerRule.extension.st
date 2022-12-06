Extension { #name : #GtSmaCCNodeVariableStylerRule }

{ #category : #'*GToolkit-Extensions' }
GtSmaCCNodeVariableStylerRule >> gtVariableNamesFor: aView [
	<gtView>
	self variableNames ifNil: [ ^ aView empty ].

	^ aView columnedList
		title: 'Variable Names';
		items: [ self variableNames ifNil: [ #() ] ];
		column: 'Name' text: #yourself
]
