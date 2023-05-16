Extension { #name : #GtSmaCCStylerRule }

{ #category : #'*GToolkit-Extensions' }
GtSmaCCStylerRule >> asStyleRulesSendWithParserClass: aParserClass [
	^ self
]

{ #category : #'*GToolkit-Extensions' }
GtSmaCCStylerRule >> gtStyleBlockFor: aView [
	<gtView>
	self styleBlock ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Style block';
		object: [ self styleBlock ];
		view: #gtSourceCodeFor:
]

{ #category : #'*GToolkit-Extensions' }
GtSmaCCStylerRule >> gtStylerRulesViewDescriptionText [
	^ ''
]
