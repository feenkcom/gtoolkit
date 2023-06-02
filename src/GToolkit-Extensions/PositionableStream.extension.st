Extension { #name : #PositionableStream }

{ #category : #'*GToolkit-Extensions' }
PositionableStream >> gtStreamStateFor: aView [
	<gtView>
	self position ifNil: [ ^ aView empty ].
	^ aView textEditor
		title: 'Contents';
		text: [ 
			| aText |
			aText := self contents asRopedText.
			(aText from: 1 to: self position) underlineColor: BrGlamorousColors errorBackgroundColor.
			aText ]
]
