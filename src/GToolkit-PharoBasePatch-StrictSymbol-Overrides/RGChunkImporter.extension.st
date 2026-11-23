Extension { #name : #RGChunkImporter }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
RGChunkImporter >> createBehavior: subclassName superclassName: superclassName instanceVariableNames: instanceVariableNames classVariableNames: classVariableNames categoryName: categoryName packageName: packageName poolDictionariesNames: poolDictionariesNames layoutClass: layoutClass layoutDefinition: layoutDefinition slotsDefinition: slotsDefinition traits: traitsDefinition isTrait: isTrait hasNilSuperclass: hasNilSuperclass [
	"The superclass name is a String from the chunk"
	<gtPharoPatch: #StrictComparison>

	| behavior superclass |

	self assert: subclassName isNotNil.

	isTrait
		ifTrue: [
			superclass := nil.
			behavior := (subclassName endsWith: ' classTrait')
				ifTrue: [
					self environment ensureMetaclassTraitNamed: subclassName ]
				ifFalse: [
					self assert: (superclassName isString and: [ superclassName asString = 'Trait' ]).
					self environment ensureTraitNamed: subclassName ]]
		ifFalse: [
			behavior := self environment ensureClassNamed: subclassName.
			hasNilSuperclass
				ifTrue: [ behavior superclass: nil. ]
				ifFalse: [
					superclassName ifNotNil: [
						| theSuperclass |
						theSuperclass := self environment ensureClassNamed: superclassName.
						behavior superclass: theSuperclass ] ] ].

	isTrait ifFalse: [
		layoutClass ifNotNil: [
			behavior layout: (layoutClass parent: behavior).
			"TODO: unknown layout definition"]].

	slotsDefinition ifNotNil: [
		behavior layout: (layoutClass parent: behavior).
		slotsDefinition children do: [:child |
			| newSlot |
			newSlot := (child isLiteralNode and: [ child value isSymbol ])
				ifTrue: [ RGInstanceVariableSlot named: child value parent: behavior layout ]
				ifFalse: [
					"TODO: probably needs more robust analysis"
					self assert: child isMessage.
					(RGUnknownSlot named: (self slotNameFor: child) parent: behavior layout)
						expression: child formattedCode;
						yourself].
			behavior layout addSlot: newSlot] .].

	"process instance variables after layout and slots"
	instanceVariableNames ifNotNil: [
		behavior instanceVariables: (instanceVariableNames substrings collect: [:each | each asSymbol])].

	classVariableNames ifNotNil: [
		behavior classVariables: (classVariableNames substrings collect: [:each | each asSymbol]) ].

	poolDictionariesNames ifNotNil: [
		behavior sharedPools: (poolDictionariesNames substrings collect: [:each | each asSymbol])].

	categoryName ifNotNil: [
		behavior category: categoryName ].

	packageName ifNotNil: [
		| pkg |
		pkg := environment ensurePackageNamed: packageName.
		behavior package: pkg ].

	traitsDefinition ifNotNil: [
		| composition transformations |
		composition := RGTraitComposition parent: behavior.
		transformations := RGTraitCompositionVisitor new parse: traitsDefinition for: composition.
		behavior traitComposition: composition.
		transformations do: [ :each |
			composition addTransformation: each ].
		]
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
RGChunkImporter >> if: selectorParts in: ast includes: aSymbol do: aBlock [
	"selectorParts are Strings (findBetweenSubstrings:), aSymbol a Symbol literal"
	<gtPharoPatch: #StrictComparison>
	| index |

	index := selectorParts indexOf: aSymbol asString ifAbsent: [^ self].
	aBlock value: (ast arguments at: index)
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
RGChunkImporter >> isNilSuperclassDefinition: ast [
	"The literal is a Symbol, the source code a String"
	<gtPharoPatch: #StrictComparison>

	^ (ast isSequence)
		and: [(ast statements size = 2)
		and: [(ast statements allSatisfy: #isMessage)
		and: [(self allowedSelectors includes: ast statements first selector)
		and: [(ast statements second selector = #superclass:)
		and: [(ast statements second arguments first value isNil)
		and: [((ast statements first arguments first value withoutPrefix: '#') asString = ast statements second receiver sourceCode)]]]]]]
]
