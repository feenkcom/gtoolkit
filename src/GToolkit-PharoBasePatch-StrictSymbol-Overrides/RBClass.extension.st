Extension { #name : #RBClass }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
RBClass >> comment [
	^ (comment sameContentAs: LookupComment)
		ifTrue: [ comment := self isDefined ifTrue: [ self realClass comment ] ifFalse: [ nil ] ]
		ifFalse: [ comment ]
]
