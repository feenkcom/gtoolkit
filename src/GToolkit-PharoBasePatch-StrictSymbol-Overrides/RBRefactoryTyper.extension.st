Extension { #name : #RBRefactoryTyper }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
RBRefactoryTyper >> guessTypesFor: anInstVarName in: aClass [
	"The guesses are keyed by instance variable names, as Strings or Symbols: look up both kinds"
	<gtPharoPatch: #StrictComparison>
	class = aClass ifFalse: [self runOn: aClass].
	^bestGuesses at: anInstVarName
		ifAbsent: [ bestGuesses at: (anInstVarName isSymbol ifTrue: [ anInstVarName asString ] ifFalse: [ anInstVarName asSymbol ]) ifAbsent: [self typesFor: anInstVarName in: aClass] ]
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
RBRefactoryTyper >> typesFor: anInstVarName [
	"The types are keyed by instance variable names, as Strings or Symbols: look up both kinds"
	<gtPharoPatch: #StrictComparison>
	^variableTypes at: anInstVarName ifAbsent: [ variableTypes at: (anInstVarName isSymbol ifTrue: [ anInstVarName asString ] ifFalse: [ anInstVarName asSymbol ]) ifAbsent: [Set new] ]
]

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
RBRefactoryTyper >> typesFor: anInstVarName in: aClass [
	"The types are keyed by instance variable names, as Strings or Symbols: look up both kinds"
	<gtPharoPatch: #StrictComparison>
	class = aClass ifFalse: [self runOn: aClass].
	^variableTypes at: anInstVarName ifAbsent: [ variableTypes at: (anInstVarName isSymbol ifTrue: [ anInstVarName asString ] ifFalse: [ anInstVarName asSymbol ]) ifAbsent: [Set new] ]
]
