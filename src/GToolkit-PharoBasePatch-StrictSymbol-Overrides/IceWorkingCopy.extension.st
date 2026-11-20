Extension { #name : #IceWorkingCopy }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
IceWorkingCopy >> includesInWorkingCopyPackageNamed: aString [
	"The packages dictionary has String and Symbol keys (both kinds in the same repository): look up both kinds"
	<gtPharoPatch: #StrictComparison>
	| aKey |
	aKey := (self packagesDictionary includesKey: aString)
		ifTrue: [ aString ]
		ifFalse: [ aString isSymbol
			ifTrue: [ aString asString ]
			ifFalse: [ aString isString
				ifTrue: [ (Symbol findInterned: aString) ifNil: [ aString ] ]
				ifFalse: [ aString ] ] ].
	^ (self packagesDictionary includesKey: aKey)
		and: [ (self packageNamed: aKey) isLoaded ]
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
IceWorkingCopy >> packageNamed: aString [
	"The packages dictionary has String and Symbol keys (both kinds in the same repository): look up both kinds"
	<gtPharoPatch: #StrictComparison>
	^ self packagesDictionary at: aString ifAbsent: [
		self packagesDictionary at: (aString isSymbol
			ifTrue: [ aString asString ]
			ifFalse: [ aString isString
				ifTrue: [ (Symbol findInterned: aString) ifNil: [ aString ] ]
				ifFalse: [ aString ] ]) ]
]
