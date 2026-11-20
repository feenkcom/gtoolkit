Extension { #name : #RBParameterRemovalRefactoring }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
RBParameterRemovalRefactoring >> applyValidations [
	"Argument names are Symbols; the argument can be given as a String"
	<gtPharoPatch: #StrictComparison>

	| tree |
	(class directlyDefinesMethod: oldSelector) ifFalse: [
		self refactoringError: 'Method doesn''t exist' ].
	tree := class parseTreeForSelector: oldSelector.
	tree ifNil: [ self refactoringError: 'Cannot parse sources' ].
	argument ifNil: [
		self refactoringError: 'This method does not have an argument' ].
	parameterIndex := tree argumentNames
		                  indexOf: (argument isString ifTrue: [ argument asSymbol ] ifFalse: [ argument ])
		                  ifAbsent: [
		                  self refactoringError: 'Select a parameter!!' ].
	oldSelector numArgs == 0 ifTrue: [
		self refactoringError: 'This method contains no arguments' ].
	oldSelector isInfix ifTrue: [
		self refactoringError:
			'Cannot remove parameters of infix selectors' ]
]
