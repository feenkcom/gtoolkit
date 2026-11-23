Extension { #name : #CategoryConverter }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
CategoryConverter >> processCategory: aString [
	"We are looking for the packages that matches the best the category and we consider the tag is what is left."
	"Package names are Symbols, the category a String"
	<gtPharoPatch: #StrictComparison>

	(self environment organization packageMatchingExtensionName: aString)
		ifNil: [ packageName := aString ]
		ifNotNil: [ :package |
			packageName := package name.
			aString asString = packageName asString ifFalse: [ tagName := aString withoutPrefix: packageName , '-' ] ]
]
