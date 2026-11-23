Extension { #name : #RBAbstractVariablesRefactoring }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
RBAbstractVariablesRefactoring >> processReferenceNode: aNode [
	"Variable names are Symbols; ignore and classVariableNames are Strings"
	<gtPharoPatch: #StrictComparison>
	| varName |
	varName := aNode name.
	(ignore isString and: [ ignore asString = varName asString ]) ifTrue: [^self].
	(aNode whoDefines: varName) ifNotNil: [^self].
	(self instanceVariableNames includes: varName)
		ifTrue: [instVarReaders add: varName].
	(self classVariableNames includes: varName asString)
		ifTrue: [classVarReaders add: varName]
]
