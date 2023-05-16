Extension { #name : #BrAsyncElementFutureReceivedSignal }

{ #category : #'*GToolkit-Extensions' }
BrAsyncElementFutureReceivedSignal >> gtSkipReasonFor: aView [
	<gtView>
	self isSkipped ifFalse: [ ^ aView empty ].

	^ aView columnedList
		title: 'Skip reason';
		priority: 0;
		items: [ self skipReasonDictionary associations ];
		column: 'Name' text: #key;
		column: 'Value'
			text: [ :anAssoc | 
				| aText |
				aText := anAssoc value asRopedText.
				anAssoc value
					ifFalse: [ aText foreground: BrGlamorousColors disabledButtonTextColor ].
				aText ];
		send: #value
]
