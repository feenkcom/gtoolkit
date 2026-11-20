Extension { #name : #ZnMultiValueDictionary }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
ZnMultiValueDictionary >> at: key [
	"Header and field names are Strings or Symbols (kept as given): look up both kinds"
	<gtPharoPatch: #StrictComparison>
	^ super at: key ifAbsent: [ super at: (key isSymbol ifTrue: [ key asString ] ifFalse: [ key isString ifTrue: [ (Symbol findInterned: key) ifNil: [ key ] ] ifFalse: [ key ] ]) ]
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
ZnMultiValueDictionary >> at: key ifAbsent: aBlock [
	"Header and field names are Strings or Symbols (kept as given): look up both kinds"
	<gtPharoPatch: #StrictComparison>
	^ super at: key ifAbsent: [ super at: (key isSymbol ifTrue: [ key asString ] ifFalse: [ key isString ifTrue: [ (Symbol findInterned: key) ifNil: [ key ] ] ifFalse: [ key ] ]) ifAbsent: aBlock ]
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
ZnMultiValueDictionary >> at: key put: anObject [
	"An existing key of the other kind (String or Symbol) is kept, as a Dictionary keeps its key when comparing Strings and Symbols by content"
	<gtPharoPatch: #StrictComparison>
	| aKey |
	aKey := ((super includesKey: key) not and: [ super includesKey: (key isSymbol ifTrue: [ key asString ] ifFalse: [ key isString ifTrue: [ (Symbol findInterned: key) ifNil: [ key ] ] ifFalse: [ key ] ]) ])
		ifTrue: [ (key isSymbol ifTrue: [ key asString ] ifFalse: [ key isString ifTrue: [ (Symbol findInterned: key) ifNil: [ key ] ] ifFalse: [ key ] ]) ]
		ifFalse: [ key ].
	self checkLimitForKey: aKey.
	^ super at: aKey put: anObject
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
ZnMultiValueDictionary >> includesKey: key [
	"Header and field names are Strings or Symbols (kept as given): look up both kinds"
	<gtPharoPatch: #StrictComparison>
	^ (super includesKey: key) or: [ super includesKey: (key isSymbol ifTrue: [ key asString ] ifFalse: [ key isString ifTrue: [ (Symbol findInterned: key) ifNil: [ key ] ] ifFalse: [ key ] ]) ]
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
ZnMultiValueDictionary >> removeKey: key [
	"Header and field names are Strings or Symbols (kept as given): look up both kinds"
	<gtPharoPatch: #StrictComparison>
	^ super removeKey: key ifAbsent: [ super removeKey: (key isSymbol ifTrue: [ key asString ] ifFalse: [ key isString ifTrue: [ (Symbol findInterned: key) ifNil: [ key ] ] ifFalse: [ key ] ]) ]
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
ZnMultiValueDictionary >> removeKey: key ifAbsent: aBlock [
	"Header and field names are Strings or Symbols (kept as given): look up both kinds"
	<gtPharoPatch: #StrictComparison>
	^ super removeKey: key ifAbsent: [ super removeKey: (key isSymbol ifTrue: [ key asString ] ifFalse: [ key isString ifTrue: [ (Symbol findInterned: key) ifNil: [ key ] ] ifFalse: [ key ] ]) ifAbsent: aBlock ]
]
