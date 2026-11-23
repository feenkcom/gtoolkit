Extension { #name : #RGEnvironmentQueryInterface }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
RGEnvironmentQueryInterface >> packageNamed: aString [
	"Ring package names are Strings or Symbols"
	<gtPharoPatch: #StrictComparison>

	self packagesDo: [:each |
		((each name isString and: [ aString isString ]) ifTrue: [ each name asString = aString asString ] ifFalse: [ each name = aString ]) ifTrue: [ ^ each ] ].

	^ nil
]
