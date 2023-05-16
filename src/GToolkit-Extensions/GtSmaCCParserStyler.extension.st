Extension { #name : #GtSmaCCParserStyler }

{ #category : #'*GToolkit-Extensions' }
GtSmaCCParserStyler >> gtStylerRulesFor: aView [
	<gtView>
	stylerRules ifNil: [ ^ aView empty ].

	^ aView columnedList
		title: 'Styler rules';
		items: [ self stylerRules ];
		column: 'Class Name' text: #className;
		column: 'Description'
			text: #gtStylerRulesViewDescriptionText
			weight: 2;
		column: 'Example'
			text: [ :aRule | 
				aRule styleBlock
					ifNil: [ '' ]
					ifNotNil: [ :aBlock | 
						aBlock numArgs = 1
							ifTrue: [ aBlock value: 'styled text' asRopedText ]
							ifFalse: [ '' ] ] ]
			width: 100;
		column: 'Continue on Match'
			text: [ :aRule | 
				| aText |
				aText := aRule continueOnMatch asRopedText.
				aRule continueOnMatch
					ifFalse: [ aText foreground: BrGlamorousColors disabledButtonTextColor ].
				aText ]
			width: 130;
		send: [ :aRule | aRule asStyleRulesSendWithParserClass: self parserClass ];
		actionUpdateButton
]
