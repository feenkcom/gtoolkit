Extension { #name : #GtSmaCCKeywordTokensStylerRule }

{ #category : #'*GToolkit-Extensions' }
GtSmaCCKeywordTokensStylerRule >> asStyleRulesSendWithParserClass: aParserClass [
	^ GtSmaCCKeywordTokensStylerRuleWrapper new
		rule: self;
		parserClass: aParserClass
]

{ #category : #'*GToolkit-Extensions' }
GtSmaCCKeywordTokensStylerRule >> gtIDSViewItems [
	^ ids
		ifNil: [ #() ]
		ifNotNil: [ :aSet | aSet asSortedCollection: [ :a :b | a < b ] ]
]
