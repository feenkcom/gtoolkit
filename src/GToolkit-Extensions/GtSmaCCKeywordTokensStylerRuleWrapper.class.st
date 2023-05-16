Class {
	#name : #GtSmaCCKeywordTokensStylerRuleWrapper,
	#superclass : #Object,
	#instVars : [
		'rule',
		'parserClass'
	],
	#category : #'GToolkit-Extensions-SmaCC'
}

{ #category : #'gt - extensions' }
GtSmaCCKeywordTokensStylerRuleWrapper >> gtIdsFor: aView [
	<gtView>
	self rule ifNil: [ ^ aView empty ].
	self parserClass ifNil: [ ^ aView empty ].

	^ aView columnedList
		title: 'IDS';
		priority: 20;
		items: [ self rule gtIDSViewItems ];
		column: 'ID'
			text: #yourself
			width: 40;
		column: 'Token Names'
			text: [ :anId | 
				String
					streamContents: [ :aStream | 
						self parserClass scannerClass keywordMap
							keysAndValuesDo: [ :aKey :aValue | 
								aValue
									keysAndValuesDo: [ :aTokenName :eachId | 
										eachId isCollection
											ifTrue: [ eachId first = anId
													ifTrue: [ aStream
															nextPutAll: aTokenName asString;
															space ] ]
											ifFalse: [ eachId = anId
													ifTrue: [ aStream
															nextPutAll: aTokenName asString;
															space ] ] ] ] ] ]
]

{ #category : #accessing }
GtSmaCCKeywordTokensStylerRuleWrapper >> gtStyleBlockFor: aView [
	<gtView>
	self rule ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Style block';
		priority: 5;
		object: [ self rule ];
		view: #gtStyleBlockFor:
]

{ #category : #accessing }
GtSmaCCKeywordTokensStylerRuleWrapper >> parserClass [
	^ parserClass
]

{ #category : #accessing }
GtSmaCCKeywordTokensStylerRuleWrapper >> parserClass: anObject [
	parserClass := anObject
]

{ #category : #accessing }
GtSmaCCKeywordTokensStylerRuleWrapper >> rule [
	^ rule
]

{ #category : #accessing }
GtSmaCCKeywordTokensStylerRuleWrapper >> rule: anObject [
	rule := anObject
]
