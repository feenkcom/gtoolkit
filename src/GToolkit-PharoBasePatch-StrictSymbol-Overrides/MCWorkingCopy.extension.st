Extension { #name : #MCWorkingCopy }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
MCWorkingCopy class >> forPackageNamed: aPackageName [
	"Package names come as Strings (MCPackage) and as Symbols (packages)"
	<gtPharoPatch: #StrictComparison>
	| aName |
	aName := aPackageName asString.
	^ self registry values
		  detect: [ :workingCopy | workingCopy packageName asString = aName ]
		  ifNone: [ NotFound signalFor: aPackageName in: self ]
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
MCWorkingCopy class >> hasPackageNamed: aName [
	"Working copy package names are Strings or Symbols (MCPackage named:); callers pass either"
	<gtPharoPatch: #StrictComparison>
	^ self allWorkingCopies anySatisfy: [ :each |
		(each packageName isString and: [ aName isString ])
			ifTrue: [ each packageName asString = aName asString ]
			ifFalse: [ each packageName = aName ] ]
]
