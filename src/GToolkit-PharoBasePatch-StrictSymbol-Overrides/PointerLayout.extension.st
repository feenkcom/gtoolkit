Extension { #name : #PointerLayout }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
PointerLayout >> resolveSlot: aName ifFound: foundBlock ifNone: noneBlock [
	^ slotScope resolveSlot: aName asSymbol ifFound: foundBlock ifNone: noneBlock
]
