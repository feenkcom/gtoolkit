Extension { #name : #IceWorkingCopy }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
IceWorkingCopy >> includesInWorkingCopyPackageNamed: aString [
	"The packages dictionary has String and Symbol keys (both kinds in the same repository): look the name up by content"
	<gtPharoPatch: #StrictComparison>
	| aKey |
	aKey := (self packagesDictionary includesKey: aString)
		ifTrue: [ aString ]
		ifFalse: [ self packagesDictionary keys
			detect: [ :each | each sameContentAs: aString ]
			ifNone: [ ^ false ] ].
	^ (self packageNamed: aKey) isLoaded
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
IceWorkingCopy >> packageNamed: aString [
	"The packages dictionary has String and Symbol keys (both kinds in the same repository): look the name up by content"
	<gtPharoPatch: #StrictComparison>
	^ self packagesDictionary at: aString ifAbsent: [
		self packagesDictionary at: (self packagesDictionary keys
			detect: [ :each | each sameContentAs: aString ]
			ifNone: [ aString ]) ]
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
IceWorkingCopy >> packageNamed: aString ifAbsent: aBlock [
	"The packages dictionary has String and Symbol keys (both kinds in the same repository): look the name up by content"
	<gtPharoPatch: #StrictComparison>
	^ self packagesDictionary at: aString ifAbsent: [
		self packagesDictionary keys
			detect: [ :each | each sameContentAs: aString ]
			ifFound: [ :aKey | self packagesDictionary at: aKey ]
			ifNone: aBlock ]
]
