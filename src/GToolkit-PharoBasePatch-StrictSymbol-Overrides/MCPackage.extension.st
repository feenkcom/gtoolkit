Extension { #name : #MCPackage }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
MCPackage >> = other [
	"MCPackage names are Strings or Symbols (MCPackage named: aPackage name); hash already ignores the kind"
	<gtPharoPatch: #StrictComparison>
	^ other species = self species and: [
		(other name isString and: [ name isString ])
			ifTrue: [ other name asString = name asString ]
			ifFalse: [ other name = name ] ]
]
