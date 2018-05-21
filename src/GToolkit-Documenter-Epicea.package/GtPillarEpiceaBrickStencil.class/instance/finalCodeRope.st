accessing - parameters
finalCodeRope
	<return: #BrRopedText>
	| aRopedText |
	aRopedText := self epiceaLog newStateString asRopedText.
	aRopedText isEmpty ifFalse: [ 
		aRopedText attributes: { BrFontGenericFamilyAttribute monospace } ].
	^ aRopedText