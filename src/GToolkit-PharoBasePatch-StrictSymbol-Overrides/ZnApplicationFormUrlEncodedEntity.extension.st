Extension { #name : #ZnApplicationFormUrlEncodedEntity }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
ZnApplicationFormUrlEncodedEntity >> at: key ifAbsent: block [
	"The fields are keyed by Strings; callers pass Symbols"
	<gtPharoPatch: #StrictComparison>
	^ self fields at: (key isSymbol ifTrue: [ key asString ] ifFalse: [ key ]) ifAbsent: block
]
