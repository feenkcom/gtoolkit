Extension { #name : #TonelReader }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
TonelReader >> categoriesFrom: aCollection [
	^ ((aCollection select: #isClassDefinition)
		collect: #category
		as: GtStringContentSet)
		sorted: [ :a :b | a < b ]
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
TonelReader >> loadDefinitions [
	| definitionOrders newDefinitions newCategories organization |

	definitionOrders := self class definitionOrders.
	newDefinitions := ((self packageDirectory entries
		select: [ :each | self canBeLoaded: each ])
		collect: [ :each | each readStreamDo: [ :s | TonelParser parseStream: s ] ])
		flattened
		sort: [ :a :b | (definitionOrders at: a class) < (definitionOrders at: b class) ].

	newCategories := self categoriesFrom: newDefinitions.
	(newCategories anySatisfy: [:each | each sameContentAs: self package name])
		ifFalse: [ newCategories := newCategories copyWithFirst: self package name ].
	organization := MCOrganizationDefinition categories: newCategories.

	definitions := (newDefinitions copyWithFirst: organization) sort
]
