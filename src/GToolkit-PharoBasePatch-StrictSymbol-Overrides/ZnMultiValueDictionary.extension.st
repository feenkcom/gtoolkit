Extension { #name : #ZnMultiValueDictionary }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
ZnMultiValueDictionary >> at: key [
	"Header and field names are Strings or Symbols (kept as given): look the name up by content"
	<gtPharoPatch: #StrictComparison>
	^ super at: (self existingKeyWithSameContentAs: key)
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
ZnMultiValueDictionary >> at: key ifAbsent: aBlock [
	"Header and field names are Strings or Symbols (kept as given): look the name up by content"
	<gtPharoPatch: #StrictComparison>
	^ super at: (self existingKeyWithSameContentAs: key) ifAbsent: aBlock
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
ZnMultiValueDictionary >> at: key put: anObject [
	"An existing key of the other kind (String or Symbol) is kept, as a Dictionary keeps its key when comparing Strings and Symbols by content"
	<gtPharoPatch: #StrictComparison>
	| aKey |
	aKey := self existingKeyWithSameContentAs: key.
	self checkLimitForKey: aKey.
	^ super at: aKey put: anObject
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
ZnMultiValueDictionary >> existingKeyWithSameContentAs: key [
	"Answer my key with the same content as key (a String and a Symbol with the same characters match), or key when I have none.
	Header and field names are kept as given, Strings or Symbols, so a lookup may come with the other kind."
	<gtPharoPatch: #StrictComparison>
	(super includesKey: key) ifTrue: [ ^ key ].
	key isString ifFalse: [ ^ key ].
	^ self keys detect: [ :each | each sameContentAs: key ] ifNone: [ key ]
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
ZnMultiValueDictionary >> includesKey: key [
	"Header and field names are Strings or Symbols (kept as given): look the name up by content"
	<gtPharoPatch: #StrictComparison>
	^ super includesKey: (self existingKeyWithSameContentAs: key)
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
ZnMultiValueDictionary >> removeKey: key [
	"Header and field names are Strings or Symbols (kept as given): look the name up by content"
	<gtPharoPatch: #StrictComparison>
	^ super removeKey: (self existingKeyWithSameContentAs: key)
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
ZnMultiValueDictionary >> removeKey: key ifAbsent: aBlock [
	"Header and field names are Strings or Symbols (kept as given): look the name up by content"
	<gtPharoPatch: #StrictComparison>
	^ super removeKey: (self existingKeyWithSameContentAs: key) ifAbsent: aBlock
]
