Extension { #name : #String }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
String >> isValidGlobalName [

	self ifEmpty: [ ^ false ].	"reserverd default names"
	self = #NameOfSubclass ifTrue: [ ^ false ].
	self = #TNameOfTrait ifTrue: [ ^ false ].

	^ (self first isLetter and: [ self first isUppercase ])
		and: [ self
				allSatisfy: [ :character | character isAlphaNumeric or: [ character = $_ ] ] ]
]
