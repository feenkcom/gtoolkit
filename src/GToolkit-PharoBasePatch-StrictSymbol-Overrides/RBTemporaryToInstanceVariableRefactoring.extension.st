Extension { #name : #RBTemporaryToInstanceVariableRefactoring }

{ #category : #'*GToolkit-PharoBasePatch-StrictSymbol-Overrides' }
RBTemporaryToInstanceVariableRefactoring >> checkForValidTemporaryVariable [
	"Variable names are Symbols; the refactoring gets a String"
	<gtPharoPatch: #StrictComparison>

	(parseTree allTemporaryVariables includes: (temporaryVariableName isString ifTrue: [ temporaryVariableName asSymbol ] ifFalse: [ temporaryVariableName ]))
		ifFalse:
			[self refactoringError: temporaryVariableName
						, ' isn''t a valid temporary variable name'].
	(parseTree allArgumentVariables includes: (temporaryVariableName isString ifTrue: [ temporaryVariableName asSymbol ] ifFalse: [ temporaryVariableName ]))
		ifTrue:
			[self refactoringError: temporaryVariableName , ' is a block parameter'].
]
