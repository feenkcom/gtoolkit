Extension { #name : #GtSmaCCParserStyler }

{ #category : #'*GToolkit-Extensions' }
GtSmaCCParserStyler >> gtStylerRulesFor: aView [
	<gtView>
	stylerRules ifNil: [ ^ aView empty ].

	^ aView columnedList
		title: 'Styler Rules';
		items: [ self stylerRules ];
		column: 'Class Name' text: #className;
		column: 'Description'
			text: #gtStylerRulesViewDescriptionText
			weight: 2;
		column: 'Continue on Match'
			text: [ :aRule | 
				| aText |
				aText := aRule continueOnMatch asRopedText.
				aRule continueOnMatch
					ifFalse: [ aText foreground: BrGlamorousColors disabledButtonTextColor ].
				aText ]
			width: 130
]
