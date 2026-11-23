Extension { #name : #RBAbstractClass }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
RBAbstractClass >> directlyDefinesInstanceVariable: aString [
	"The model holds the names as Strings (instanceVariableNames:) or as Symbols (from the real class); callers pass either"
	<gtPharoPatch: #StrictComparison>
	| aName |
	aName := aString asString.
	^ self instanceVariableNames anySatisfy: [ :each | each asString = aName ]
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
RBAbstractClass >> removeInstanceVariable: aString [
	"The model holds the names as Strings or Symbols (see directlyDefinesInstanceVariable:): remove the stored one"
	<gtPharoPatch: #StrictComparison>
	| aName |
	aName := aString asString.
	self privateInstanceVariableNames remove: (self privateInstanceVariableNames
		detect: [ :each | each asString = aName ]
		ifNone: [ aString ]).
	model removeInstanceVariable: aString from: self
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
RBAbstractClass >> removeInstanceVariable: aString ifAbsent: aBlock [
	"The model holds the names as Strings or Symbols (see directlyDefinesInstanceVariable:): remove the stored one"
	<gtPharoPatch: #StrictComparison>
	| aName |
	aName := aString asString.
	self privateInstanceVariableNames
		remove: (self privateInstanceVariableNames
			detect: [ :each | each asString = aName ]
			ifNone: [ aString ])
		ifAbsent: aBlock.
	model removeInstanceVariable: aString from: self
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
RBAbstractClass >> renameInstanceVariable: oldName to: newName around: aBlock [
	"The names can be Strings or Symbols (see directlyDefinesInstanceVariable:)"
	<gtPharoPatch: #StrictComparison>
	| anOldName |
	anOldName := oldName asString.
	self privateInstanceVariableNames
		at: (self privateInstanceVariableNames findFirst: [ :each | each asString = anOldName ])
		put: newName asString.
	^ self model
		  perform: aBlock
		  onlyWithChange:
		  (changeFactory
			   renameInstanceVariable: oldName
			   to: newName
			   in: self)
]
