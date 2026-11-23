Extension { #name : #MetacelloVersionSpec }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
MetacelloVersionSpec >> packageNamed: aString forMap: map ifAbsent: absentBlock [
	"The map is keyed by Strings (see MetacelloMemberListSpec>>#mapAdd:into:); the names come as Strings and as Symbols"
	<gtPharoPatch: #StrictComparison>

	| importSpec aName |
	aName := aString isSymbol ifTrue: [ aString asString ] ifFalse: [ aString ].
	^ map at: aName ifAbsent: [
		  (self importArray isNotNil or: [ self import isNotNil ]) ifTrue: [ "expect the 'missing' name to be satisfied within context of imported project"
			  importArray ifNotNil: [
				  importArray do: [ :assoc | | aKey |
					  aKey := assoc key isSymbol ifTrue: [ assoc key asString ] ifFalse: [ assoc key ].
					  ((assoc value anySatisfy: [ :each | (each isString and: [ aName isString ])
								ifTrue: [ each asString = aName asString ]
								ifFalse: [ each = aName ] ])
						and: [ map includesKey: aKey ]) ifTrue: [
						  importSpec := (map at: aKey)
							                mergeImportLoads: { aString };
							                yourself ] ].
				  importSpec ifNotNil: [ ^ importSpec ] ].
			  (importSpec isNil and: [ self import isNotNil ]) ifTrue: [
				  ^ (map at: (self import isSymbol ifTrue: [ self import asString ] ifFalse: [ self import ]) ifAbsent: absentBlock)
					    mergeImportLoads: { aString };
					    yourself ] ].
		  (aName = 'default' or: [ aName = 'ALL' ])
			  ifTrue: [
				  self project groupSpec
					  name: aString;
					  includes: self packageNames;
					  yourself ]
			  ifFalse: [ absentBlock value ] ]
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
MetacelloVersionSpec >> specsNamed: packageAndProjectNames projectDo: projectBlock packageDo: packageBlock groupDo: groupBlock [
	"The map is keyed by Strings (see MetacelloMemberListSpec>>#mapAdd:into:)"
	<gtPharoPatch: #StrictComparison>

	| map |
	map := self packages map.
	packageAndProjectNames do: [ :name |
		(map at: (name isSymbol ifTrue: [ name asString ] ifFalse: [ name ]) ifAbsent: [  ]) ifNotNil: [ :pkgSpec | pkgSpec projectDo: projectBlock packageDo: packageBlock groupDo: groupBlock ] ]
]
