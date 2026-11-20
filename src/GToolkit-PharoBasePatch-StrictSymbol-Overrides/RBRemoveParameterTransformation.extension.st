Extension { #name : #RBRemoveParameterTransformation }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
RBRemoveParameterTransformation >> getNewSelector [
	"Argument names are Symbols; the argument can be given as a String"
	<gtPharoPatch: #StrictComparison>
	| tree |
	(class directlyDefinesMethod: oldSelector)
		ifFalse: [ self refactoringError: 'Method doesn''t exist' ].
	tree := class parseTreeForSelector: oldSelector.
	tree ifNil: [ self refactoringError: 'Cannot parse sources' ].
	argument ifNil:[ self refactoringError: 'This method does not have an argument' ].
	parameterIndex := tree argumentNames indexOf: (argument isString ifTrue: [ argument asSymbol ] ifFalse: [ argument ]) ifAbsent: [ self refactoringError: 'Select a parameter!!' ].
	permutation := (1 to: oldSelector numArgs) copyWithout: parameterIndex.
	newSelector := self computeNewSelector
]
