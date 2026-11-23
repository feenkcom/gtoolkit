Extension { #name : #MetacelloMemberListSpec }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
MetacelloMemberListSpec >> mapAdd: aMemberSpec into: map [
	"Baselines name packages and groups with Strings and with Symbols: key the map by Strings (see MetacelloPackagesSpec>>#packageNamed:ifAbsent:)"
	<gtPharoPatch: #StrictComparison>
	
	map at: (aMemberSpec name isSymbol ifTrue: [ aMemberSpec name asString ] ifFalse: [ aMemberSpec name ]) put: aMemberSpec spec
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
MetacelloMemberListSpec >> mapCopy: aMemberSpec into: map [
	"The map is keyed by Strings (see mapAdd:into:)"
	<gtPharoPatch: #StrictComparison>
	| aName aSourceName |
	aName := aMemberSpec name isSymbol ifTrue: [ aMemberSpec name asString ] ifFalse: [ aMemberSpec name ].
	aSourceName := aMemberSpec sourceName isSymbol ifTrue: [ aMemberSpec sourceName asString ] ifFalse: [ aMemberSpec sourceName ].
	(map at: aSourceName ifAbsent: [  ])
		ifNil: [ self error: 'Source spec named ' , aMemberSpec sourceName printString , ' not found' ]
		ifNotNil: [ :spec |
			spec aboutToCopy.
			map at: aName put: (spec copy mergeSpec: aMemberSpec spec copy) ]
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
MetacelloMemberListSpec >> mapMerge: aMemberSpec into: map [
	"The map is keyed by Strings (see mapAdd:into:)"
	<gtPharoPatch: #StrictComparison>
	| aName |
	aName := aMemberSpec name isSymbol ifTrue: [ aMemberSpec name asString ] ifFalse: [ aMemberSpec name ].
	(map at: aName ifAbsent: [  ])
		ifNotNil: [ :spec | map at: aName put: (spec mergeSpec: aMemberSpec spec) ]
		ifNil: [ map at: aName put: aMemberSpec spec copy ]
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
MetacelloMemberListSpec >> mapRemove: aMemberSpec into: map [
	"The map is keyed by Strings (see mapAdd:into:)"
	<gtPharoPatch: #StrictComparison>
	
	map removeKey: (aMemberSpec name isSymbol ifTrue: [ aMemberSpec name asString ] ifFalse: [ aMemberSpec name ]) ifAbsent: []
]
