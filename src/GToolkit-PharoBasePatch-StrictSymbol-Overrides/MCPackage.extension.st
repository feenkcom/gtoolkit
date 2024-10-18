Extension { #name : #MCPackage }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
MCPackage >> name [
	^ name asSymbol
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
MCPackage >> name: aString [
	name := aString ifNotNil: [ aString asSymbol ]
]
