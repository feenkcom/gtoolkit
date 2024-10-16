Extension { #name : #AbstractLayoutScope }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
AbstractLayoutScope >> resolveSlot: aName ifFound: foundBlock ifNone: exceptionBlock [
	self
		allSlotsDo: [ :slot | (slot name sameContentAs: aName) ifTrue: [ ^ foundBlock cull: slot ] ].
	^ exceptionBlock value
]
