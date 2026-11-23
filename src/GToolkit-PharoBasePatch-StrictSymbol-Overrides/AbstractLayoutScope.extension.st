Extension { #name : #AbstractLayoutScope }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
AbstractLayoutScope >> resolveSlot: aName ifFound: foundBlock ifNone: exceptionBlock [
	"Slot names are Symbols; Object>>#instVarNamed: and #slotNamed: are often called with Strings"
	<gtPharoPatch: #StrictComparison>
	| aSlotName |
	aSlotName := aName isString ifTrue: [ aName asSymbol ] ifFalse: [ aName ].
	self allSlotsDo: [ :slot |
		slot name = aSlotName ifTrue: [ ^ foundBlock cull: slot ]].
	^ exceptionBlock value
]
