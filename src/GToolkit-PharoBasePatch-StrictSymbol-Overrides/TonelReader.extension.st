Extension { #name : #TonelReader }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
TonelReader >> categoriesFrom: aCollection [
	^ ((aCollection select: #isClassDefinition)
		collect: #category
		as: GtStringContentSet)
		sorted: [ :a :b | a < b ]
]
