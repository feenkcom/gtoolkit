Extension { #name : #RBAbstractVariablesRefactoring }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
RBAbstractVariablesRefactoring >> processReferenceNode: aNode [
	| varName |
	varName := aNode name.
	(ignore sameContentAs: varName) ifTrue: [ ^ self ].
	(aNode whoDefines: varName) ifNotNil: [ ^ self ].
	(self instanceVariableNames includes: varName)
		ifTrue: [ instVarReaders add: varName ].
	(self classVariableNames includes: varName)
		ifTrue: [ classVarReaders add: varName ]
]
